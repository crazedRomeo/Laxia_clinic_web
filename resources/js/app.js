import Vue from 'vue'
import store from '~/store'
import router from '~/router'
import i18n from '~/plugins/i18n'
import App from '~/components/App'
import utils from './helpers/utilities'
import VueSweetalert2 from 'vue-sweetalert2';
import VueLazyLoad from 'vue-lazyload'
import ToggleButton from 'vue-js-toggle-button'
import Firebase from 'firebase'
import Multiselect from 'vue-multiselect'
import VCalendar from 'v-calendar';
import VueTimepicker from 'vue2-timepicker'
import 'vue2-timepicker/dist/VueTimepicker.css'

require("./firebase_info")

Vue.use(VueLazyLoad)
Vue.use(ToggleButton)
Vue.component('multiselect', Multiselect);
Vue.component('vue-timepicker', VueTimepicker);
Vue.use(VCalendar);
const moment = require('moment')
require('moment/locale/ja')
Vue.use(require('vue-moment'), { moment })

import '~/plugins'
import '~/components'

global.Vue = require('vue')
Vue.prototype.$utils = utils

require('./helpers/directives')

Vue.use(VueSweetalert2, {
  confirmButtonText: 'はい',
  cancelButtonText: 'いいえ',
});

Vue.filter("currency", function (value) {
  value = parseInt(value);
  return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "円";
});
Vue.filter('formatDate', function(value) {
  if (value) {
    return moment(String(value)).format('YYYY年MM月DD日')
  }
});
Vue.filter('formatDateWithOutDay', function(value) {
  if (value) {
    return moment(String(value)).format('YYYY年MM月')
  }
});
Vue.filter('formatDateTimeWithDay', function(value) {
  if (value) {
    return moment(String(value)).format('YYYY/MM/DD(ddd) HH:mm')
  }
});
Vue.filter('formatDateWithDay', function(value) {
  if (value) {
    return moment(String(value)).format('MM月DD日(ddd)')
  }
});

Vue.filter('formatDateWithTime', function(value) {
  if (value) {
    return moment(String(value)).format('MM月DD日(ddd) HH:mm')
  }
});
Vue.filter('formatTime', function(value) {
  return value.substr(0, 5);
});
Vue.filter('formatTelephone', function(value) {
  return value.substr(value.length - 11);
});
Vue.filter('formatTime12', function(value) {
  if (value) {
    return moment(String(value)).format('HH:mm')
  }
});

Vue.config.productionTip = false

var firebaseApp = Firebase.initializeApp(window.firebaseConfig);
window.firestore = firebaseApp.firestore();

/* eslint-disable no-new */
new Vue({
  i18n,
  store,
  router,
  ...App
})
