import Vue from 'vue'
import App from './App.vue'
import VueRouter from 'vue-router'
import { routes } from './routes'
import vuetify from './plugins/vuetify';
import jsPDF from 'jspdf';
import firebase from 'firebase'
// import pdfkit from 'pdfkit'

Vue.use(VueRouter);
Vue.use(jsPDF);
// Vue.use(pdfkit);

firebase.initializeApp({
  apiKey: "AIzaSyACiBa-xNmSTXRWS33dVBfYG4yzTPdI2o4",
  authDomain: "serucehealth.firebaseapp.com",
  databaseURL: "https://serucehealth.firebaseio.com",
  projectId: "serucehealth",
  storageBucket: "serucehealth.appspot.com",
  messagingSenderId: "1039792233979",
  appId: "1:1039792233979:web:c38469909cb0f27f35ff5e"
});

const router = new VueRouter({ routes, mode: 'history' });
Vue.config.productionTip = false

new Vue({
  vuetify,
  router,
  render: h => h(App)
}).$mount('#app')
