import Login from './components/Landing/Login'
import Signup from './components/Landing/Signup'
import Profile from './components/Profile'
import Account from './components/Account'
import Event from './components/Event'
import Presc from './components/Presc'
import Patient from './components/Patient'
import Diary from './components/PersonalDiary'
import past from './components/PastPresc'
import Vaccine from './components/Vaccine'


export const routes = [
    { path: '', component: Login },
    { path:'/signup', component: Signup },
    { path: '/profile', component: Profile, children: [
        { path: '/profile/account', component: Account },
        { path: '/profile/patient', component: Patient },
        { path: '/profile/event', component: Event },
        { path: '/profile/presc', component: Presc },
        { path:'/profile/diary', component: Diary },
        { path: '/profile/past', component: past },
        { path: '/profile/vaccine', component: Vaccine },
    ] }
];