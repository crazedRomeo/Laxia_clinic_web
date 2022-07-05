<template>
  <div v-if="is_master_loaded" class="main-in pd-0">
    <div class="main-content case-content main-dev-content">
      <div class="staff-header case-header">
          <select class="menu-sort" @change="handleCategoryChange">
            <option value="-1">{{ $t('施術で絞り込む') }}</option>
            <option v-for="item in search_categories" :key="item.id" :value="item.id">{{ item.name }}</option>
          </select>
          <!-- <select class="staff-sort form-control" @change="handleStuffChange">
            <option value="-1">{{ $t('担当者でソート') }}</option>
            <option v-for="(name, id) in stuffs" :key="id" :value="id">{{ name }}</option>
          </select> -->
          <button class="btn btn-primary" @click="handleNewCase"><img src="/img/plus.svg" class="img_plus"> {{ $t('新規症例を追加') }}</button>
      </div>
      <div class="staff-content case-sub-content">
        <div class="case-list">
          <div v-for="(item, index) in cases" :key="index" class="case-one">
            <div class="case-one-in" @click="handleShowCase(item.id)">
              <div class="case-img">
                <p class="before">
                  <template v-for="(item, key) in item.images" :value="key">
                    <img v-if="item.img_type == 0" :src="item.path" :key="key">
                  </template>
                  <!-- <img v-else :src="'/img/menu-img.png'"> -->
                </p>
                <p class="after">
                  <!-- <img v-if="tmp.afterPhotos.length" :src="'/storage/'+tmp.afterPhotos[0]"> -->
                   <template v-for="(item, key) in item.images" :value="key">
                    <img v-if="item.img_type == 1" :src="item.path" :key="key">
                  </template>
                  <!-- <img v-else :src="'/img/menu-img.png'"> -->
                  <!-- <img v-else class="menu-blank-img"> -->
                </p>
              </div>
              <div class="case-info">
                <p class="case-cat empty-cat" v-if="item.categories.length === 0"></p>
                <template v-for="(item, key) in item.categories" :value="key">
                  <p class="case-cat" v-if="key <= 3" :key="key">
                    {{ item.name }}
                  </p>
                </template>
                <p class="case-ttl">{{item.name}}</p>
                <p class="case-name"><!--<i class="fas fa-clipboard-list"></i>--><img src="/img/clip_book.svg" style="margin-top: -2px; margin-right:4px;">  <template v-if="item.menus.length">{{ item.menus[0].name}}</template></p>
              </div>
            </div>
          </div>
        </div>
        <pagination
        v-if="pageInfo"
        :page="query.page"
        :page-count="pageInfo.last_page"
        :click-handler="handlePaginate" />
      </div>
    </div>

    <form-modal
      ref="modal"
      id="case-modal"
      :title="modalInfo.title"
      @cancel="handleModalClose"
      >
      <!-- <vue-custom-scrollbar class="scroll-modal-body" :settings="settings" @ps-scroll-y="scrollHanle"> -->
      <div class="scroll-modal-body">
        <div v-if="form">
          <div class="create-case-content">
          <div class="form-group row mt-0">
            <div class="col-12">
              <small>{{ $t('タイトル') }}</small>
              <input type="text" id="case_name" v-model="form.cases.name" placeholder="例：奥二重の方の二重切開" class="form-control" :class="{'is-invalid' : errors && errors['cases.name'] && form.cases.name == '', 'is-valid' : errors && !errors['cases.name'] && showstatus && form.cases.name != ''}"  @keyup="inputValid" />
              <!-- <i v-if="errors && errors['cases.name'] && showstatus" class="i-text-invalid bi bi-exclamation-triangle-fill"></i> -->
              <i v-if="errors && !errors['cases.name'] && showstatus" class="i-text-valid bi bi-check-circle-fill"></i>
              <div v-if="errors && errors['cases.name']" class="error invalid-feedback">{{ errors['cases.name'][0] }}</div>
            </div>
          </div>
          <div class="form-group row justify-content-center case-file-upload">
            <div class="col-6">
              <small class="text-center">{{ $t('Before画像') }}</small>
              <file-upload
                ref="beforeFileUploadComponent"
                uploadUrl="/api/clinic/cases/before/photoupload"
                :maxFiles="10"
                :autoStatus="true"
                name="menu-images"
                @file-upload-success="handleMultiFileSaved"
                @file-removed="hanleMultiFileRemove"
                @file-added="handleMultiFileAdded"
                @queue-complete="handleMultiFilesQueueComplete"
              />

            </div>
            <div class="col-6">
              <small class="text-center">{{ $t('After画像') }}</small>
              <file-upload
                ref="afterFileUploadComponent"
                uploadUrl="/api/clinic/cases/after/photoupload"
                :maxFiles="10"
                :autoStatus="true"
                name="menu-images"
                @file-upload-success="handleAfterMultiFileSaved"
                @file-removed="hanleAfterMultiFileRemove"
                @file-added="handleAfterMultiFileAdded"
                @queue-complete="handleAfterMultiFilesQueueComplete"
              />
            </div>
          </div>
          <div class="form-group row case-photo-content">
            <div class="col-12">
              <small v-if="form.beforePhotos.length" class="mb-0">{{ $t('Before画像') }}</small>
              <div v-if="form.beforePhotos.length" class="company-profile-img-list">
                <div v-for="(img, index) in form.beforePhotos" class="company-image--edit" :key="index">
                  <div class="over-hidden">
                    <img :src="img" />
                  </div>
                  <span class="remove-btn" @click="handleBeforeRemoveFile(index)">
                    <svg width="13" height="13" viewBox="0 0 13 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path d="M6.49998 0.25C3.04826 0.25 0.25 3.04835 0.25 6.50008C0.25 9.9518 3.04826 12.75 6.49998 12.75C9.9518 12.75 12.7501 9.9518 12.7501 6.50008C12.7501 3.04835 9.9518 0.25 6.49998 0.25ZM9.39685 8.38102L8.38131 9.39685L6.49998 7.51551L4.61882 9.39685L3.60321 8.38102L5.48445 6.49969L3.60321 4.61872L4.61875 3.60309L6.49998 5.48445L8.38124 3.60309L9.39685 4.61853L7.51551 6.49969L9.39685 8.38102Z" fill="#131340"/>
                    </svg>
                  </span>
                </div>
              </div>
            </div>
            <div class="col-12 mt-2">
              <small v-if="form.afterPhotos.length" class="mb-0">{{ $t('After画像') }}</small>
              <div v-if="form.afterPhotos.length" class="company-profile-img-list">
                <div v-for="(img, index) in form.afterPhotos" class="company-image--edit" :key="index">
                  <div class="over-hidden">
                    <img :src="img" />
                  </div>
                  <span class="remove-btn" @click="handleAfterRemoveFile(index)">
                    <svg width="13" height="13" viewBox="0 0 13 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path d="M6.49998 0.25C3.04826 0.25 0.25 3.04835 0.25 6.50008C0.25 9.9518 3.04826 12.75 6.49998 12.75C9.9518 12.75 12.7501 9.9518 12.7501 6.50008C12.7501 3.04835 9.9518 0.25 6.49998 0.25ZM9.39685 8.38102L8.38131 9.39685L6.49998 7.51551L4.61882 9.39685L3.60321 8.38102L5.48445 6.49969L3.60321 4.61872L4.61875 3.60309L6.49998 5.48445L8.38124 3.60309L9.39685 4.61853L7.51551 6.49969L9.39685 8.38102Z" fill="#131340"/>
                    </svg>
                  </span>
                </div>
              </div>
            </div>
          </div>
          <div class="form-group row mt-2">
            <div class="col-12">
              <small>{{ $t('メニュー') }}</small>
              <select v-model="form.cases.menu_id" class="form-control" :class="{'is-invalid' : errors && errors['cases.menu_id'] }" @change="handleMenuChange($event)">
                <option></option>
                <option v-for="(name, id) in menus" :key="id" :value="id" >{{ name }}</option>
              </select>
              <div v-if="errors && errors['cases.menu_id']" class="error invalid-feedback">{{ errors['cases.menu_id'][0] }}</div>
            </div>
          </div>
          <div class="form-group" v-if="menu_detail_data.length">
            <div class="row">
              <div class="col-7">
                <small>{{ $t('メニュー名') }}</small>
              </div>
              <div class="col-3">
                <small>{{ $t('料金') }}</small>
              </div>
              <div class="col-2 text-center">
                <small>{{ $t('削除') }}</small>
              </div>
            </div>
            <!-- <template v-for="(item, id) in menu_detail_data" :value="id">
              <MenuDetail :m_menu_data="item" :m_idx="id" :key="id"/>
            </template> -->
            <MenuDetail />
          </div>
          <div class="form-group row">
            <div class="col-12">
              <small>{{ $t('カテゴリー') }}</small>
              <multiselect
                :options="category_options"
                :multiple="false"
                group-values="children"
                group-label="group_name"
                :group-select="true"
                track-by="name"
                label="name"
                selectLabel=""
                selectGroupLabel=""
                placeholder=""
                selectedLabel="選択済み"
                deselectLabel="削除"
                deselectGroupLabel="削除"
                @select="handleCateChange"
                :class="{'is-invalid' : errors && errors['categories'] && selected_categories.length == 0 }"
              ></multiselect>
              <div v-if="errors && errors['categories'] && selected_categories.length == 0" class="error invalid-feedback d-block">{{ errors['categories'][0] }}</div>
              <div class="view-cate-panel mt-2">
                <template v-for="(item, idx) in selected_categories" :value="id">
                  <p :key="idx">
                    {{item.group}} / {{item.name}}
                    <i class="bi bi-x" @click="removeCategory(idx)"></i>
                  </p>
                </template>
              </div>
            </div>
          </div>

          <!-- <div class="form-group row">
            <div class="col-12">
                <small>{{ $t('担当者') }}</small>
                <select v-model="form.cases.stuff_id" :class="{'is-invalid' : errors && errors['cases.stuff_id'] }">
                  <option></option>
                  <option v-for="(name, id) in stuffs" :key="id" :value="id">{{ name }}</option>
                </select>
                <div v-if="errors && errors['cases.stuff_id']" class="error invalid-feedback">{{ errors['cases.stuff_id'][0] }}</div>
            </div>
          </div> -->
          <div class="form-group row">
            <div class="col-6">
                <small>{{ $t('年齢') }}</small>
                <!-- <select v-model="form.cases.patient_age" class="form-control" :class="{'is-invalid' : errors && errors['cases.patient_age'] }">
                  <option></option>
                  <option v-for="i in 7" :key="i" :value="i * 10">{{ i * 10 }}{{ $t('代') }}</option>
                </select> -->
                <c-select
                  :options="ageOptions"
                  :textkey="'text'"
                  :valkey="'val'"
                  :emptyable="true"
                  class="select"
                  ref="ageSelect"
                  @change="selectedAge"
                  :class="{'is-invalid' : errors && errors['cases.patient_age'] && (form.cases.patient_age == null || form.cases.patient_age == '') }"
              />
                <div v-if="errors && errors['cases.patient_age']" class="error invalid-feedback">{{ errors['cases.patient_age'][0] }}</div>
            </div>
            <div class="col-6">
              <small>{{ $t('性別') }}</small>
              <!-- <select v-model="form.cases.patient_gender" class="form-control" :class="{'is-invalid' : errors && errors['cases.patient_gender'] }">
                <option v-for="(name, id) in genders" :key="id" :value="id">{{ name }}</option>
              </select> -->
              <c-enum-select
                  :options="genders"
                  :emptyable="true"
                  :default="form.cases.patient_gender"
                  class="select"
                  ref="genderSelect"
                  @change="selectedGender"
                  :class="{'is-invalid' : errors && errors['cases.patient_gender'] && (form.cases.patient_gender == null || form.cases.patient_gender == '')}"
                />
              <div v-if="errors && errors['cases.patient_gender']" class="error invalid-feedback">{{ errors['cases.patient_gender'][0] }}</div>
            </div>
          </div>
          <div class="create-case-text">
            <small>{{ $t('施術の解説') }}</small>
            <textarea v-model="form.cases.case_description" class="form-control" :class="{'is-invalid' : errors && errors['cases.case_description'] && form.cases.case_description == ''}" placeholder="例：この施術は目頭を切る施術になります。"></textarea>
            <div v-if="errors && errors['cases.case_description']" class="error invalid-feedback">{{ errors['cases.case_description'][0] }}</div>
          </div>
          <div class="create-case-text">
            <small>{{ $t('副作用・リスク') }}</small>
            <textarea v-model="form.cases.treat_risk" class="form-control" :class="{'is-invalid' : errors && errors['cases.treat_risk'] && form.cases.treat_risk == ''}" placeholder="例：施術後一週間ほど腫れる場合があります。"></textarea>
            <div v-if="errors && errors['cases.treat_risk']" class="error invalid-feedback">{{ errors['cases.treat_risk'][0] }}</div>
          </div>
          <div class="create-case-text">
            <small>{{ $t('担当ドクターからのコメント') }}</small>
            <textarea v-model="form.cases.doctor_opinion" class="form-control" placeholder="例：この施術は〇〇な方に向いているかと思います。"></textarea>
            <!-- <div v-if="errors && errors['cases.treat_risk']" class="error invalid-feedback">{{ errors['cases.treat_risk'][0] }}</div> -->
          </div>
          </div>
        </div>
      </div>
      <!-- </vue-custom-scrollbar> -->
      <template v-slot:footer>
        <button type="button" class="btn btn-primary" @click="handleUpdateCase">{{ modalInfo.confirmBtnTitle }}</button>
      </template>
    </form-modal>

    <form-modal
      ref="viewModal"
      id="case-view-modal"
      :title="modalInfo.title"
      >
      <!-- <vue-custom-scrollbar class="scroll-modal-body" :settings="settings" @ps-scroll-y="scrollHanle"> -->
      <div class="scroll-modal-body">
      <div v-if="form" class="create-menu-content view-modal-content">
        <div class="form-group row">
          <div class="col">
            <small>{{ $t('タイトル') }}</small>
            <p>{{form.cases.name}} 埋没法ダブル</p>
          </div>
        </div>
        <div class="form-group row">
          <div class="col">
            <small>{{ $t('Before画像') }}</small>
            <div class="view-img-panel">
              <template v-for="(item, id) in form.beforePhotos" :value="id">
                <img :src="item" :key="id">
              </template>
            </div>
          </div>
        </div>
        <div class="form-group row">
          <div class="col">
            <small>{{ $t('After画像') }}</small>
            <div class="view-img-panel">
              <template v-for="(item, id) in form.afterPhotos" :value="id">
                <img :src="item" :key="id">
              </template>
            </div>
          </div>
        </div>
        <div class="form-group">
          <div class="row">
            <div class="col-9">
              <small>{{ $t('メニュー名') }}</small>
            </div>
            <div class="col-3">
              <small>{{ $t('料金') }}</small>
            </div>
          </div>
          <div class="row mb-2" v-for="(item, idx) in selected_menu_details" :key="idx">
            <div class="col-9">
              <p>{{item.name}}</p>
            </div>
            <div class="col-3">
              <p>{{item.price}}</p>
            </div>
          </div>
        </div>
        <div class="form-group row">
          <div class="col">
            <small>{{ $t('カテゴリー') }}</small>
            <div class="view-cate-panel">
              <template v-for="(item, idx) in selected_categories" :value="id">
                <p :key="idx">
                  {{item.name}}
                </p>
              </template>
            </div>
          </div>
        </div>
        <div class="form-group row">
          <div class="col-6">
            <small>{{ $t('年齢') }}</small>
            <p>{{form.cases.patient_age}}{{ $t('代') }}</p>
          </div>
          <div class="col-6">
            <small>{{ $t('性別') }}</small>
            <template v-for="(name, id) in genders" :value="id">
              <p v-if="form.cases.patient_gender == id" :key="id">
                {{name}}
              </p>
            </template>
          </div>
        </div>
        <div class="form-group row">
          <div class="col">
            <small>{{ $t('施術の解説') }}</small>
            <p class="pre-wrap">{{form.cases.case_description}}</p>
          </div>
        </div>
        <div class="form-group row">
          <div class="col">
            <small>{{ $t('副作用・リスク') }}</small>
            <p class="pre-wrap">{{form.cases.treat_risk}}</p>
          </div>
        </div>
        <div class="form-group row">
          <div class="col">
            <small class="pre-wrap">{{ $t('担当ドクターからのコメント') }}</small>
            <p>{{form.cases.doctor_opinion}}</p>
          </div>
        </div>
      </div>
      </div>
      <!-- </vue-custom-scrollbar> -->
      <template v-slot:footer>
        <button type="button" class="btn btn-primary" @click="handleShowEditMenu">{{ modalInfo.confirmBtnTitle }}</button>
      </template>
    </form-modal>
  </div>
</template>

<script>
import axios from 'axios'
import { mapGetters } from 'vuex'
import Multiselect from 'vue-multiselect'
import vueCustomScrollbar from 'vue-custom-scrollbar'
import "vue-custom-scrollbar/dist/vueScrollbar.css"

export default {
  middleware: 'auth',

  components: {
    vueCustomScrollbar
  },

  data() {
    return {
      cases: [],
      form: undefined,
      errors: undefined,
      tmp: {
        beforeFileChanged: false,
        afterFileChanged: false,
        cases: {
          menu_id: '',
          stuff_id: '',
          patient_age: '',
          name: '',
          patient_gender: '',
          case_description: '',
          doctor_opinion: '',
          treat_risk: '',
          before_photo: '',
          after_photo: '',
        },
        categoires: null,
        afterPhotos: [],
        beforePhotos: [],
      },
      query: {
        per_page: 12,
        page: 1,
        stuff_id: '',
        category_id: ''
      },
      modalInfo: {
        title: '',
        confirmBtnTitle: '',
      },
      pageInfo: undefined,
      fileUploadCount: 0,
      selected_categories: [],
      selected_menu_details: [],
      showstatus: false,
      settings: {
        suppressScrollY: false,
        suppressScrollX: true,
        wheelPropagation: false
      },
      ageOptions: [
        {'val': 10, 'text': '10代'},
        {'val': 20, 'text': '20代'},
        {'val': 30, 'text': '30代'},
        {'val': 40, 'text': '40代'},
        {'val': 50, 'text': '50代'},
        {'val': 60, 'text': '60代'},
        {'val': 70, 'text': '70代'},
      ]
    }
  },

  computed: {
    ...mapGetters({
      is_master_loaded: 'state/is_master_loaded',
      specialities: 'data/specialities',
      categories: 'data/categories',
      stuffs: 'data/stuffs',
      menus: 'data/menus',
      menu_details: 'data/menu_details',
      genders: 'constant/gender_types'
    }),
    category_options() {
      return this.categories.map(el => {
        return {
          group_name: el.name,
          children: el.all_children.map(item => {
            return {
              id: item.id,
              name: item.name,
            };
          }),
        };
      });
    },
    menu_detail_data() {
      return this.$store.state.data.selected_menus;
    },
    search_categories() {
      let tc = [];

      this.categories.map(el => {
        el.all_children.map(item => {
          tc.push({
            id: item.id,
            name: item.name,
          });
        });
      });

      return tc;
    },
  },

  mounted() {
    this.getData();
  },

  methods: {
    handleMenuChange(e){
      // let menuOpts = e.target.children;
      // this.form.cases.menu_id = menuOpts[0].value;

      this.menu_details.forEach(item => {
        if(item.id == e.target.value){
          this.selected_menu_details.push({
            id: item.id,
            name: item.name,
            price: item.price
          })
        }
      })

      this.$store.dispatch('data/addMenuDetails', { data : this.selected_menu_details })
    },
    handleCateChange(option){
      let opt_groud_name = "";
      this.category_options.forEach(item => {
        opt_groud_name = item.group_name;
          item.children.forEach(child => {
            if (option.id == child.id) {
              if (!this.selected_categories.map(item => item.id).includes(child.id)) {
                this.selected_categories.push({
                  id: child.id,
                  name: child.name,
                  group:opt_groud_name
                })
              }
            }
          })
        })
    },
    removeCategory(idx) {
      this.selected_categories.splice(idx, 1);
    },
    inputValid(e){
      // this.errors['cases.name'] = '';
      // this.showstatus = false;
      // const objName = document.querySelector('#case_name');
      // objName.classList.remove('is-valid');
    },
    getData() {
      this.$store.dispatch('state/setIsLoading')
      const qs = this.$utils.getQueryString(this.query)
      axios.get(`/api/clinic/cases?${qs}`)
        .then(res => {
          this.cases = res.data.cases.data;
          this.pageInfo = {
            last_page: res.data.cases.last_page,
          }
          this.$store.dispatch('state/removeIsLoading')
        })
        .catch(error => {
          this.$store.dispatch('state/removeIsLoading')
        })
    },

    handleShowCase(id) {
      let selected = this.cases.find(el => el.id == id);
      this.form = {
        ...this.tmp,
        cases: { ...selected },
        // beforePhotos : selected.images.map(el => el.path),
      }

      this.selected_categories = []
      let opt_groud_name;
      this.category_options.forEach(item => {
        opt_groud_name = item.group_name;
        item.children.forEach(child => {
          if (selected.categories.map(item => item.id).includes(child.id)) {
            this.selected_categories.push({
              id: child.id,
              name: child.name,
              group:opt_groud_name
            })
          }
        })
      })

      this.form.beforePhotos = [];
      this.form.afterPhotos = [];
      selected.images.forEach(child => {
        if (child.img_type == 1) {
          this.form.afterPhotos.push(child.path)
        }else{
          this.form.beforePhotos.push(child.path)
        }
      })

      this.selected_menu_details = [];
      this.menu_details.forEach(item => {
      if(selected.menus.map(item => item.id).includes(item.id)){
          this.selected_menu_details.push({
            id: item.id,
            name: item.name,
            price: item.price
          })
        }
      })
      this.$store.dispatch('data/addMenuDetails', { data : this.selected_menu_details })

      this.errors = undefined
      this.modalInfo = {
        title: '症例の詳細',
        confirmBtnTitle: '症例内容を編集する'
      }
      this.$refs.viewModal.show()
    },

    handleShowEditMenu(){
      this.modalInfo = {
        title: '症例を編集',
        confirmBtnTitle: '症例の編集を完了'
      }
      this.$refs.viewModal.hide();
      this.$refs.modal.show();
    },

    handleNewCase() {
      this.form = {
        ...this.tmp,
        cases: { ...this.tmp.cases }
      }
      this.selected_categories = [];
      this.selected_menu_details = [];
      this.form.beforePhotos = [];
      this.form.afterPhotos = [];
      this.errors = undefined;
      this.$store.dispatch('data/addMenuDetails', { data : this.selected_menu_details })
      this.modalInfo = {
        title: '症例を追加する',
        confirmBtnTitle: '症例を追加する'
      }

      if(this.$refs.genderSelect) this.$refs.genderSelect.set(this.form.cases.patient_gender);
      if(this.$refs.ageSelect) this.$refs.ageSelect.set(this.form.cases.patient_age);
      this.$refs.modal.show();
    },

    handleUpdateCase() {
      this.$store.dispatch('state/setIsLoading')
      let flg = false;
      // if (this.form.beforeFileChanged) {
      //   flg = true
      //   this.$refs.beforeFileUploadComponent.processQueue();
      // }
      // if (this.form.afterFileChanged) {
      //   flg = true
      //   this.$refs.afterFileUploadComponent.processQueue();
      // }
      if (!flg) {
        this.handleSaveCase();
      }
    },

    handleUpdateCase1(){
      this.$refs.beforeFileUploadComponent.processQueue();
    },

    handleSaveCase() {
      this.showstatus = true;
      let isCreate = true
      let url = '/api/clinic/cases';
      if (this.form.cases.id) {
        url += `/${this.form.cases.id}`
        isCreate = false
      }
      this.form = {
        ...this.form,
        categories: this.selected_categories.map(el => el.id),
        menus: this.menu_detail_data.map(el => el.id)
      }

      axios.post(url, this.form)
        .then(res => {
          this.$store.dispatch('state/removeIsLoading')
          this.errors = undefined
          this.fileUploadCount = 0
          this.$refs.modal.hide()
          this.$swal({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            title: '登録しました。',
            icon: 'success',
          })
          if (isCreate) {
            this.query = {
              ...this.query,
              page: 1,
            }
          }
          this.getData()
        })
        .catch(error => {
          this.errors = { ...error.response.data.errors }
          this.form.beforeFileChanged = false
          this.form.afterFileChanged = false
          this.fileUploadCount = 0
          this.$store.dispatch('state/removeIsLoading')
        })
    },

    handlePaginate(pageNum) {
      this.query = {
        ...this.query,
        page: pageNum,
      }
      this.getData()
    },

    handleModalClose() {
      this.$refs.beforeFileUploadComponent.removeAllFiles()
      this.$refs.afterFileUploadComponent.removeAllFiles()
    },

    handleFileSaved(filePath, name) {
      this.form = {
        ...this.form,
        cases: {
          ...this.form.cases,
          [name]: filePath,
          [name + '_thumb_url']: ''
        },
      }

      this.fileUploadCount++;
      if (this.form.beforeFileChanged && this.form.afterFileChanged) {
        if (this.fileUploadCount == 2) this.handleSaveCase();
      } else {
        this.handleSaveCase();
      }
    },

    hanleFileRemove(name) {
      let changeKey = ''
      if (name == 'before_photo') {
        changeKey = 'beforeFileChanged'
      } else {
        changeKey = 'afterFileChanged'
      }
      this.form[changeKey] = false;
      this.form.cases[name] = ''
    },

    handleFileAdded(flg, name) {
      let changeKey = ''
      if (name == 'before_photo') {
        changeKey = 'beforeFileChanged'
      } else {
        changeKey = 'afterFileChanged'
      }
      this.form[changeKey] = flg;
    },

    handleMultiFileSaved(fileUrl) {
      this.form.beforePhotos.push(fileUrl)
    },

    hanleMultiFileRemove(id) {
      console.log("remove", id);
      let length = this.$refs.beforeFileUploadComponent.getQueuedFiles();
      if (!length) {
        this.form.beforeFileChanged = false;
      }
    },

    handleMultiFileAdded(flg) {
      this.form.beforeFileChanged = flg;
      // this.$refs.beforeFileUploadComponent.processQueue();
    },

    handleMultiFilesQueueComplete() {
      this.form.beforeFileChanged = false
      console.log(this.form.beforePhotos)
      // this.handleSaveCase()
    },
    handleMultipleUploadComplete(url){
      console.log(url);
    },

    handleAfterMultiFileSaved(fileUrl) {
      this.form.afterPhotos.push(fileUrl)
    },

    hanleAfterMultiFileRemove(id) {
      console.log("remove", id);
      let length = this.$refs.beforeFileUploadComponent.getQueuedFiles();
      if (!length) {
        this.form.afterFileChanged = false;
      }
    },

    handleAfterMultiFileAdded(flg) {
      this.form.afterFileChanged = flg;
      // this.$refs.beforeFileUploadComponent.processQueue();
    },

    handleAfterMultiFilesQueueComplete() {
      this.form.afterFileChanged = false
      // this.handleSaveCase()
    },

    handleBeforeRemoveFile(index) {
      this.form.beforePhotos.splice(index, 1)
    },

    handleAfterRemoveFile(index) {
      this.form.afterPhotos.splice(index, 1)
    },

    handleCategoryChange(e) {
      e.preventDefault();
      this.query.category_id = e.target.value
      this.getData()
    },

    handleStuffChange(e) {
      e.preventDefault();
      this.query.stuff_id = e.target.value
      this.getData()
    },
    scrollHanle(evt) {
      // console.log(evt)
    },

    selectedAge(selected_option) {
      this.form.cases.patient_age = selected_option ? selected_option.val : null;
    },

    selectedGender(selected_option) {
      this.form.cases.patient_gender = selected_option;
    }
  }
}
</script>

<style scoped>
.case-content {
  padding: 0px 30px;
}
.case-header {
      border-bottom: 0px;
}
.form-group {
  margin-top: 1.5rem;
}
.form-group input, .form-group select {
  min-height: 40px;
  padding: 3px 12px;
  width: 100%;
}
div.create-menu-content {
  padding: 0;
}
.view-modal-footer {
  display: flex;
  justify-content: center;
}
.vue-dropzone:hover {
  background-color: #fff !important;
}
* >>> .is-invalid .multiselect__tags {
    border-color: #dc3545 !important;
}
* >>> .is-invalid .selected {
    border-color: #dc3545 !important;
}
</style>
