import React, { Component } from 'react';
import { Icon, Panel, Timeline } from 'rsuite';
import firebase from 'firebase';

interface Annotation {
  body: string;
  book: string;
  owner: string;
  page: number;
  target: string;
  id: string;
  date: { seconds: number; nanoseconds: number };
}

interface AppDashboardProps {}
interface AppDashboardState {
  notes: Annotation[];
  loading: boolean;
  page: number;
  prevY: number;
}

export default class AppDashboard extends Component<
  AppDashboardProps,
  AppDashboardState
> {
  loadingRef: HTMLDivElement | null;
  observer: IntersectionObserver | null;

  constructor(props: AppDashboardProps) {
    super(props);

    this.loadingRef = null;
    this.observer = null;
    this.state = {
      notes: [],
      loading: false,
      page: 0,
      prevY: 0,
    };

    this.handleObserver = this.handleObserver.bind(this);
  }

  componentDidMount() {
    this.getNotes(this.state.page);
    this.observer = new IntersectionObserver(this.handleObserver, {
      root: null,
      rootMargin: '0px',
      threshold: 1.0,
    });
    this.observer.observe(this.loadingRef as Element);
  }

  getNotes(page = 0) {
    this.setState({ loading: true });
    firebase
      .firestore()
      .collection('annotations')
      .orderBy('date', 'desc')
      .limit(100)
      .get()
      .then((querySnapshot) => {
        const notes: Annotation[] = [];

        querySnapshot.forEach((doc) => {
          const note = doc.data() as Annotation;
          note.id = doc.id;
          notes.push(note);
        });

        this.setState({ loading: false, notes });
      })
      .catch(() => {
        console.error('Error adding document');
      });
  }

  handleObserver(entries: IntersectionObserverEntry[]) {
    const y = entries[0].boundingClientRect.y;

    if (this.state.prevY > y) {
      const currentPage = this.state.page;
      this.getNotes(currentPage);
      this.setState({ page: currentPage + 1 });
    }

    this.setState({ prevY: y });
  }

  toDate(seconds: number) {
    const d = new Date(1970, 0, 1);
    d.setSeconds(seconds);
    return d.toLocaleString();
  }

  render() {
    return (
      <Panel>
        <Timeline className='custom-timeline'>
          {this.state.notes.map((note) => (
            <Timeline.Item key={note.id} dot={<Icon icon='user' />}>
              <p>
                {this.toDate(note.date.seconds)} | {note.owner}
              </p>
              <p>
                [{note.page}, {note.book}] {note.body}
              </p>
            </Timeline.Item>
          ))}
        </Timeline>
        <div
          ref={(loadingRef) => (this.loadingRef = loadingRef)}
          style={{
            height: '100px',
            margin: '30px',
          }}
        >
          <span style={{ display: this.state.loading ? 'block' : 'none' }}>
            Loading...
          </span>
        </div>
      </Panel>
    );
  }
}
