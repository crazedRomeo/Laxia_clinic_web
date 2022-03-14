<template>
  <main>
    <div class="main">
      <navbar />
      <child />
    </div>
    <sidebar />
    <the-spinner v-if="is_loading" />
    <div class="menu-overlay" @click.prevent="$utils.toggleSidebar"></div>
  </main>
</template>

<script>
import axios from 'axios'
import { mapGetters } from 'vuex'
import Navbar from '~/components/Navbar'
import Sidebar from '~/components/Sidebar'
import TheSpinner from '~/components/TheSpinner'

export default {
  name: 'MainLayout',

  components: {
    Navbar,
    Sidebar,
    TheSpinner
  },

  mounted() {
    this.loadMasterData()
    this.loadDbData()
    this.registerFirebase()
  },

  watch:{
    $route (to, from){
      if (this.$utils.hasClass(document.getElementsByClassName('hamburger')[0], 'is-active')) {
        this.$utils.toggleSidebar()
      }
    }
  },

  computed: mapGetters({
    user: 'auth/user',
    is_loading: 'state/is_loading',
  }),

  methods: {
    loadMasterData() {
      axios.get('/api/clinic/load/enum')
        .then(res => {
          this.$store.dispatch('constant/saveGenderTypes', { gender_types : res.data.genders })
          this.$store.dispatch('constant/saveRsvStatusTypes', { rsv_status_types : res.data.rsv_status })
          this.$store.dispatch('constant/saveRsvSourceTypes', { rsv_source_types : res.data.rsv_sources })
          this.$store.dispatch('constant/saveMenuMasuiTypes', { masui : res.data.masui })
          this.$store.dispatch('constant/saveMenuBleedingTypes', { bleeding : res.data.bleeding })
          this.$store.dispatch('constant/saveMenuHospitalNeedTypes', { hospital_need : res.data.hospital_need })
          this.$store.dispatch('constant/saveMenuHospitalVisitTypes', { hospital_visit : res.data.hospital_visit })
          this.$store.dispatch('constant/saveMenuMakeupTypes', { makeup : res.data.makeup })
          this.$store.dispatch('constant/saveMenuMassageTypes', { massage : res.data.massage })
          this.$store.dispatch('constant/saveMenuPainTypes', { pain : res.data.pain })
          this.$store.dispatch('constant/saveMenuShowerTypes', { shower : res.data.shower })
          this.$store.dispatch('constant/saveMenuSportImpossibleTypes', { sport_impossible : res.data.sport_impossible })
          this.$store.dispatch('constant/saveMenuBasshiTypes', { basshi : res.data.basshi })
          this.$store.dispatch('constant/saveMenuHareTypes', { hare : res.data.hare })
          this.$store.dispatch('constant/saveMenuTreatTimeTypes', { treat_time : res.data.treat_time })
          this.$store.dispatch('constant/saveMenuRequiredTimeTypes', { required_time : res.data.required_time })
          this.$store.dispatch('state/setIsEnumLoaded')
        })
    },

    loadDbData() {
      axios.get('/api/clinic/load/master')
        .then(res => {
          this.$store.dispatch('data/saveJobs', { jobs : res.data.jobs })
          this.$store.dispatch('data/saveRsvContents', { rsv_contents : res.data.rsvContents })
          this.$store.dispatch('data/saveSpecialities', { specialities : res.data.specialities })
          this.$store.dispatch('data/saveCategories', { categories : res.data.categories })
          this.$store.dispatch('data/savePrefs', { prefs : res.data.prefs })
          this.$store.dispatch('data/saveStuffs', { stuffs : res.data.stuffs })
          this.$store.dispatch('data/saveMenus', { menus : res.data.menus })
          this.$store.dispatch('data/saveMenuDetails', { menu_details : res.data.menuDetails })
          this.$store.dispatch('state/setIsMasterLoaded')
        })
    },

    registerFirebase() {
      if (!this.user || this.user.firebase_key) return;

      let self = this
      firestore.collection('users').add({
        user_id: this.user.id,
        // name: this.user.name,
        // message_unread: 0,
        // system_message: ''
      })
      .then(function (docRef) {
        axios.post('/api/clinic/update/firebase', {
          firebase_key: docRef.id,
        })
        .then(res => {
          self.$store.dispatch('auth/updateUser', { user: res.data.user })
        })
      })
    },
  }
}
</script>
