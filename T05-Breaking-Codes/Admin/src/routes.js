import Login from './components/Landing/Login'
import Profile from './components/Profile'
import Event from './components/Event'
import Pending from './components/Pending'
import Approved from './components/Approved'

export const routes = [
    { path: '', component: Login },
    { path: '/admin', component: Profile, children: [
        { path: '/admin/event', component: Event },
        { path: '/admin/pending', component: Pending },
        { path: '/admin/approved', component: Approved },
    ] }
];