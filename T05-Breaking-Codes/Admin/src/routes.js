import Login from './components/Landing/Login'
import Profile from './components/Profile'
import Account from './components/Account'
import Event from './components/Event'
import Presc from './components/Presc'
import Patient from './components/Patient'
import Diary from './components/PersonalDiary'
import past from './components/PastPresc'

export const routes = [
    { path: '', component: Login },
    { path: '/admin', component: Profile, children: [
        { path: '/admin/account', component: Account },
        { path: '/admin/patient', component: Patient },
        { path: '/admin/event', component: Event },
        { path: '/admin/presc', component: Presc },
        { path:'/admin/diary', component: Diary },
        { path: '/admin/past', component: past }
    ] }
];