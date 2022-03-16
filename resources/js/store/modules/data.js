import * as types from '../mutation-types'

// state
export const state = {
  stuffs: [],
  menus: [],
  menu_details: [],
  jobs: [],
  categories: [],
  prefs: [],
  specialities: [],
  selected_menus: [],
}

// getters
export const getters = {
  jobs: state => state.jobs,
  stuffs: state => state.stuffs,
  menus: state => state.menus,
  specialities: state => state.specialities,
  categories: state => state.categories,
  prefs: state => state.prefs,
  menu_details: state => state.menu_details,
}

// mutations
export const mutations = {
  [types.SAVE_STUFFS] (state, { stuffs }) {
    state.stuffs = stuffs
  },

  [types.ADD_STUFF] (state, { stuff }) {
    state.stuffs = {
      ...state.stuffs,
      [stuff.id]: stuff.name
    }
  },

  [types.SAVE_MENUS] (state, { menus }) {
    state.menus = menus
  },

  [types.ADD_MENU] (state, { menu }) {
    state.menus = {
      ...state.menus,
      [menu.id]: menu.name
    }
  },

  [types.SAVE_JOBS] (state, { jobs }) {
    state.jobs = jobs
  },

  [types.SAVE_SPECIALITIES] (state, { specialities }) {
    state.specialities = specialities
  },

  [types.SAVE_CATEGORIES] (state, { categories }) {
    state.categories = categories
  },

  [types.SAVE_PREFS] (state, { prefs }) {
    state.prefs = prefs
  },

  [types.SAVE_MENU_DETAILS] (state, { menu_details }) {
    state.menu_details = menu_details
  },

  [types.ADD_MENU_DETAILS] (state, { data }) {
    state.selected_menus = data
  },
}

// actions
export const actions = {
  saveStuffs ({ commit }, payload) {
    commit(types.SAVE_STUFFS, payload)
  },

  addStuff({commit}, payload) {
    commit(types.ADD_STUFF, payload)
  },

  saveMenuDetails({ commit }, payload) {
    commit(types.SAVE_MENU_DETAILS, payload)
  },

  saveMenus ({ commit }, payload) {
    commit(types.SAVE_MENUS, payload)
  },

  addMenu({commit}, payload) {
    commit(types.ADD_MENU, payload)
  },  

  saveJobs ({ commit }, payload) {
    commit(types.SAVE_JOBS, payload)
  },

  saveSpecialities ({ commit }, payload) {
    commit(types.SAVE_SPECIALITIES, payload)
  },

  saveCategories ({ commit }, payload) {
    commit(types.SAVE_CATEGORIES, payload)
  },

  savePrefs ({ commit }, payload) {
    commit(types.SAVE_PREFS, payload)
  },

  addMenuDetails({ commit }, payload) {
    commit(types.ADD_MENU_DETAILS, payload)
  },
}
