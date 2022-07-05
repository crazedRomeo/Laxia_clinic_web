<template>
  <div class="main-in">
    <div class="main-content">
      <div v-if="clinic" class="company-content edit-close">
        <div class="company-name">
          <span>{{ $t('クリニックロゴ') }}</span>
        </div>
        <div class="company-img">
          <img v-if="clinic.photo" :src="clinic.photo" />
          <img v-else src="/img/dummy-01.png">
        </div>

        <div class="company-info row">
          <div class="col-6">
            <div>
              <span>{{ $t('クリニック名') }}</span>
              <p>{{ clinic.name | emptyValue }}</p>
            </div>
            <div>
              <span>{{ $t('住所') }}</span>
              <p>{{ clinic.address | emptyValue }}</p>
            </div>
            <div>
              <span>{{ $t('最寄駅') }}</span>
              <p>{{ clinic.nearest_station | emptyValue }}</p>
            </div>
            <div>
              <span>{{ $t('アクセス') }}</span>
              <p>{{ clinic.access | emptyValue }}</p>
            </div>
            <!-- <div>
              <span>{{ $t('休業日') }}</span>
              <p>{{ clinic.holidays | emptyValue }}</p>
            </div> -->
            <div>
              <span>{{ $t('公式サイト') }}</span>
              <p>{{ clinic.site | emptyValue }}</p>
            </div>
            <div>
              <span>{{ $t('電話番号') }}</span>
              <p>{{ clinic.phone_number | emptyValue }}</p>
            </div>
          </div>

          <div class="col-6">
            <div>
              <span>{{ $t('クレジットカード') }}</span>
              <p>{{ clinic.credit_card | emptyValue }}</p>
            </div>
            <div>
              <span>{{ $t('駐車場') }}</span>
              <p>{{ clinic.parking | emptyValue }}</p>
            </div>
            <div>
              <span>{{ $t('営業時間') }}</span>
              <div v-for="(item, index) in clinic.work_times" :key="index" class="work-time">
                <p>{{ item.weekday }}</p>
                <p v-if="item.type == null">未入力</p>
                <p v-else-if="item.type == 0&&item.start_time!=null&&item.end_time!=null">{{ startTimeOptions.find(el => el.val ==item.start_time)['text']}} ~ {{ startTimeOptions.find(el => el.val ==item.end_time)['text']}}</p>
                <p v-else-if="item.type == 0">未入力</p>
                <p v-else>定休日</p>
              </div>
            </div>
          </div>
        </div>

        <div v-if="clinic.images.length > 0" class="company-profile-imgs">
          <span class="payment-ttl">{{ $t('クリニック紹介写真') }}</span>
          <div class="company-profile-img-list">
            <div v-for="(attachment, index) in clinic.images" :key="index">
              <img :src="attachment.path" />
            </div>
          </div>
        </div>
        <!-- <div class="company-about">
          <p class="payment-ttl">{{ $t('会社紹介') }}</p>
          <div class="company-ttl">
            <span>{{ $t('タイトル') }}</span>
            <p>{{ clinic.company_title }}</p>
          </div>
          <div class="company-txt">
            <span>{{ $t('会社紹介文') }}</span>
            <p>{{ clinic.company_profile }}</p>
          </div>
        </div> -->
        <!-- <div class="btn-wrapper"><button class="btn btn-primary " @click="handleEditProfile">{{ $t('プロフィールを編集') }}</button></div> -->
        <div class="btn-wrapper"><button class="btn btn-primary " @click="handleEditProfile">{{ $t('プロフィールを編集') }}</button></div>
      </div>
    </div>

    <form-modal
      ref="modal"
      id="menu-modal"
      :title="modalInfo.title"
      @cancel="handleModalClose"
      >
      <!-- <div v-if="form" class="company-content companu-content--edit">
        <div class="company-img">
          <file-upload
            ref="fileUploadComponent"
            uploadUrl="/api/clinic/photoupload"
            :photo="form.clinic.photo"
            @file-upload-success="handleFileSaved"
            @file-removed="hanleFileRemove"
            @file-added="handleFileAdded"
          />
        </div>
        <div class="company-name">
          <span>{{ $t('クリニック名') }}</span>
          <input type="text" v-model="form.clinic.name" :class="{'is-invalid' : errors && errors['clinic.name'] }">
          <div v-if="errors && errors['clinic.name']" class="error invalid-feedback">{{ errors['clinic.name'][0] }}</div>
        </div>
        <div class="company-info">
          <div>
            <span>{{ $t('住所') }}</span>
            <div class="clinic-info--address-block">
              <select v-model="form.clinic.pref_id" @change="changePref">
                <option></option>
                <option v-for="(name, id) in prefs" :key="id" :value="id">{{ name }}</option>
              </select>
              <span>></span>
              <select v-model="form.clinic.addr01" @change="changeCity">
                <option></option>
                <option v-for="(city, id) in cities" :key="id" :value="city.name">{{ city.name }}</option>
              </select>
              <span>></span>
              <select v-model="form.clinic.addr02">
                <option></option>
                <option v-for="(town, id) in towns" :key="id" :value="town.name">{{ town.name }}</option>
              </select>
            </div>
            <div><input type="text" v-model="form.clinic.department" :class="{'is-invalid' : errors && errors['clinic.department'] }"></div>
            <div v-if="errors && errors['clinic.department']" class="error invalid-feedback">{{ errors['clinic.department'][0] }}</div>
          </div>
          <div>
            <span>{{ $t('ネット予約') }}</span>
            <input type="text" v-model="form.clinic.net_reservation" :class="{'is-invalid' : errors && errors['clinic.net_reservation'] }">
            <div v-if="errors && errors['clinic.net_reservation']" class="error invalid-feedback">{{ errors['clinic.net_reservation'][0] }}</div>
          </div>
          <div>
            <span>{{ $t('最寄駅') }}</span>
            <input type="text" v-model="form.clinic.nearest_station" :class="{'is-invalid' : errors && errors['clinic.nearest_station'] }">
            <div v-if="errors && errors['clinic.nearest_station']" class="error invalid-feedback">{{ errors['clinic.nearest_station'][0] }}</div>
          </div>
          <div>
            <span>{{ $t('公式サイト') }}</span>
            <input type="text" v-model="form.clinic.site" :class="{'is-invalid' : errors && errors['clinic.name01'] }">
            <div v-if="errors && errors['clinic.name02']" class="error invalid-feedback">{{ errors['clinic.name02'][0] }}</div>
          </div>
          <div>
            <span>{{ $t('アクセス') }}</span>
            <input type="text" v-model="form.clinic.access" :class="{'is-invalid' : errors && errors['clinic.access'] }">
            <div v-if="errors && errors['clinic.access']" class="error invalid-feedback">{{ errors['clinic.access'][0] }}</div>
          </div>
          <div>
            <span>{{ $t('電話番号') }}</span>
            <input type="text" v-model="form.clinic.phone_number" :class="{'is-invalid' : errors && errors['clinic.phone_number'] }">
            <div v-if="errors && errors['clinic.phone_number']" class="error invalid-feedback">{{ errors['clinic.phone_number'][0] }}</div>
          </div>
          <div>
            <span>{{ $t('営業時間') }}</span>
            <input type="text" v-model="form.clinic.working_time" :class="{'is-invalid' : errors && errors['clinic.working_time'] }">
            <div v-if="errors && errors['clinic.working_time']" class="error invalid-feedback">{{ errors['clinic.working_time'][0] }}</div>
          </div>
          <div>
            <span>{{ $t('クレジットカード') }}</span>
            <input type="text" v-model="form.clinic.credit_card" :class="{'is-invalid' : errors && errors['clinic.credit_card'] }">
            <div v-if="errors && errors['clinic.credit_card']" class="error invalid-feedback">{{ errors['clinic.credit_card'][0] }}</div>
          </div>
          <div>
            <span>{{ $t('休業日') }}</span>
            <input type="text" v-model="form.clinic.holidays" :class="{'is-invalid' : errors && errors['clinic.holidays'] }">
            <div v-if="errors && errors['clinic.holidays']" class="error invalid-feedback">{{ errors['clinic.holidays'][0] }}</div>
          </div>
          <div>
            <span>{{ $t('駐車場') }}</span>
            <input type="text" v-model="form.clinic.parking" :class="{'is-invalid' : errors && errors['clinic.name01'] }">
            <div v-if="errors && errors['clinic.name02']" class="error invalid-feedback">{{ errors['clinic.name02'][0] }}</div>
          </div>
        </div>
        <div class="company-profile-imgs">
          <p class="payment-ttl">会社プロフィール画像</p>
          <div v-if="form.companyPhotos.length" class="company-profile-img-list">
            <div v-for="(img, index) in form.companyPhotos" class="company-image--edit" :key="index">
              <span class="remove-btn" @click="handleRemoveFile(index)"></span>
              <div class="over-hidden">
                <img :src="img" />
              </div>
            </div>
          </div>
          <file-upload
            ref="multiFilesUploadComponent"
            uploadUrl="/api/clinic/company-photo-upload"
            :maxFiles="10"
            name="company-images"
            @file-upload-success="handleMultiFileSaved"
            @file-removed="hanleMultiFileRemove"
            @file-added="handleMultiFileAdded"
            @queue-complete="handleMultiFilesQueueComplete"
          />
        </div>
        <div class="company-about">
          <p class="payment-ttl">会社紹介</p>
          <div class="company-ttl">
            <span>タイトル</span>
            <input type="text" v-model="form.clinic.company_title" :class="{'is-invalid' : errors && errors['clinic.company_title'] }">
            <div v-if="errors && errors['clinic.company_title']" class="error invalid-feedback">{{ errors['clinic.company_title'][0] }}</div>
          </div>
          <div class="company-txt">
            <span>会社紹介文</span>
            <textarea v-model="form.clinic.company_profile" :class="{'is-invalid' : errors && errors['clinic.company_profile'] }"></textarea>
            <div v-if="errors && errors['clinic.company_profile']" class="error invalid-feedback">{{ errors['clinic.company_profile'][0] }}</div>
          </div>
        </div>
        <div class="btn-wrapper">
          <button class="btn btn-primary" @click="isEditing = false">キャンセル</button>
          <button class="btn btn-primary" @click="handleUpdate">プロフィールを保存</button>
        </div>
      </div> -->
      <div class="scroll-modal-body clinic">
        <div v-if="form" class="create-menu-content">
          <div class="form-group row companu-content--edit menu-file-upload">
            <div class="col-md-12">
              <small>{{ $t('クリニックロゴ') }}</small>
              <file-upload
                ref="fileUploadComponent"
                uploadUrl="/api/clinic/stuffs/photoupload"
                :photo='form.clinic.photo'
                :avatar="true"
                @file-upload-success="handleFileSaved"
                @file-removed="hanleFileRemove"
                @file-added="handleFileAdded"
              />
            </div>
          </div>
          <div class="form-group">
              <small>{{ $t('クリニック名') }}</small>
              <input type="text" v-model="form.clinic.name" placeholder="例：ABCクリニック" :class="{'is-invalid' : errors && errors['clinic.name'] && form.clinic.name == ''}">
              <div v-if="errors && errors['clinic.name']" class="error invalid-feedback">{{ errors['clinic.name'][0] }}</div>
          </div>
          <div class="form-group">
            <div>
              <small>{{ $t('住所') }}</small>
              <div class="clinic-info--address-block">
                <!-- <select v-model="form.clinic.pref_id">
                  <option>北海道</option>
                </select> -->
                <c-select
                  :options="addressOptions"
                  :textkey="'text'"
                  :valkey="'val'"
                  :emptyable="true"
                  class="select"
                  ref="address"
                  @change="selectedAdress"
              />
                <i class="bi bi-chevron-left"></i>
                <c-select
                  :options="addressOptions"
                  :textkey="'text'"
                  :valkey="'val'"
                  :emptyable="true"
                  class="select"
                  ref="address"
                  @change="selectedAdress"
              />
                <i class="bi bi-chevron-left"></i>
                <c-select
                  :options="addressOptions"
                  :textkey="'text'"
                  :valkey="'val'"
                  :emptyable="true"
                  class="select"
                  ref="address"
                  @change="selectedAdress"
              />
              </div>
              <div><input type="text" v-model="form.clinic.addr02" placeholder="例：ABCビル 3階" :class="{'is-invalid' : errors && errors['clinic.addr02'] }"></div>
              <div v-if="errors && errors['clinic.addr02']" class="error invalid-feedback">{{ errors['clinic.addr02'][0] }}</div>
            </div>
          </div>
          <div class="form-group">
            <small>{{ $t('最寄駅') }}</small>
            <input type="text" v-model="form.clinic.nearest_station" placeholder="例：渋谷駅、代官山駅" :class="{'is-invalid' : errors && errors['clinic.nearest_station'] }">
            <div v-if="errors && errors['clinic.nearest_station']" class="error invalid-feedback">{{ errors['clinic.nearest_station'][0] }}</div>
          </div>
          <div class="form-group">
            <small>{{ $t('アクセス') }}</small>
            <input type="text" v-model="form.clinic.access" placeholder="例：渋谷駅から徒歩5分" :class="{'is-invalid' : errors && errors['clinic.access'] }">
            <div v-if="errors && errors['clinic.access']" class="error invalid-feedback">{{ errors['clinic.access'][0] }}</div>
          </div>
          <div>
            <small>営業時間</small>
          </div>
          <div class="form-group clinic-time" v-for="(item, index) in form.clinic.work_times" :key="index">
            <div class="clinic-weekday_lbl"><p>{{ item.weekday }}</p></div>
            <div>
              <span>営業ステータス</span>
              <!-- <select>
                <option>営業日</option>
                <option>定休日</option>
              </select> -->
              <c-select
                  :options="statusOptions"
                  :tabindex="index"
                  :default="item.type"
                  :textkey="'text'"
                  :valkey="'val'"
                  :emptyable="true"
                  class="select"
                  ref="status01"
                  @change="selectedStatus01"
              />
            </div>
            <div>
              <span>開始時間</span>
              <!-- <select>
                <option></option>
                <option>0:00</option>
              </select> -->
              <c-select
                  :options="startTimeOptions"
                  :tabindex="index"
                  :default="item.start_time"
                  :textkey="'text'"
                  :valkey="'val'"
                  :emptyable="true"
                  class="select"
                  ref="startTime"
                  @change="selectedStartTime"
              />
            </div>
            <span class="p-t-20">~</span>
            <div>
              <span>終了時間</span>
              <!-- <select>
                <option></option>
                <option>0:00</option>
              </select> -->
              <c-select
                  :options="startTimeOptions"
                  :tabindex="index"
                  :default="item.end_time"
                  :textkey="'text'"
                  :valkey="'val'"
                  :emptyable="true"
                  class="select"
                  ref="endTime"
                  @change="selectedEndTime"
              />
            </div>
          </div>
          <div class="form-group">
            <small>{{ $t('公式サイト') }}</small>
            <input type="text" v-model="form.clinic.site" placeholder="例：abc.com" :class="{'is-invalid' : errors && errors['clinic.site'] }">
            <div v-if="errors && errors['clinic.site']" class="error invalid-feedback">{{ errors['clinic.site'][0] }}</div>
          </div>
          <div class="form-group">
            <small>{{ $t('電話番号(ハイフンなし)') }}</small>
            <input type="text" v-model="form.clinic.phone_number" placeholder="例：012001234" :class="{'is-invalid' : errors && errors['clinic.phone_number'] }">
            <div v-if="errors && errors['clinic.phone_number']" class="error invalid-feedback">{{ errors['clinic.phone_number'][0] }}</div>
          </div>
          <div class="form-group">
            <small>{{ $t('対応クレジットカード') }}</small>
            <input type="text" v-model="form.clinic.credit_card" placeholder="例：Visa、Master、Amex" :class="{'is-invalid' : errors && errors['clinic.credit_card'] }">
            <div v-if="errors && errors['clinic.credit_card']" class="error invalid-feedback">{{ errors['clinic.credit_card'][0] }}</div>
          </div>
          <div class="form-group">
            <small>{{ $t('駐車場') }}</small>
            <input type="text" v-model="form.clinic.parking" placeholder="例：専用駐車場あり、近くに有料パーキングあり、など" :class="{'is-invalid' : errors && errors['clinic.parking'] }">
            <div v-if="errors && errors['clinic.parking']" class="error invalid-feedback">{{ errors['clinic.parking'][0] }}</div>
          </div>
          <div class="form-group row companu-content--edit menu-file-upload">
            <div class="col-md-12">
              <small>{{ $t('クリニック紹介画像') }}</small>
              <file-upload
                ref="multiFilesUploadComponent"
                uploadUrl="/api/clinic/menus/photoupload"
                :maxFiles="10"
                :autoStatus="true"
                name="menu-images"
                @file-upload-success="handleMultiFileSaved"
                @file-removed="hanleMultiFileRemove"
                @file-added="handleMultiFileAdded"
                @queue-complete="handleMultiFilesQueueComplete"
              />
              <div v-if="form.clinic.images.length" class="company-profile-img-list">
                <div v-for="(img, index) in form.clinic.images" class="company-image--edit" :key="index">
                  <div class="over-hidden">
                    <img :src="img" />
                  </div>
                  <span class="remove-btn" @click="handleRemoveFile(index)">
                    <svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <circle cx="6" cy="6" r="6" fill="#5F6377"/>
                      <path d="M8 4L4 8" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                      <path d="M4 4L8 8" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <template v-slot:footer>
        <button type="button" class="btn btn-primary btn-modal-footer" @click="handleUpdate">{{ modalInfo.confirmBtnTitle }}</button>
      </template>
    </form-modal>
  </div>
</template>

<script>
import axios from 'axios'
import { mapGetters } from 'vuex'

export default {
  middleware: 'auth',

  data() {
    return {
      clinic: undefined,
      form: undefined,
      errors: undefined,
      tmp: {
        avatarFileChanged: false,
        companyPhotoFileChanged: false,
        clinic: undefined,
        companyPhotos: []
      },
      modalInfo: {
        title: '',
        confirmBtnTitle: '',
      },
      cities: [],
      towns: [],
      statusOptions: [
        {'val': 0, 'text': '営業日'},
        {'val': 1, 'text': '定休日'},
      ],
      addressOptions: [
        {'val': 0, 'text': '北海道'},
      ],
      startTimeOptions: [
        {'val': 0, 'text': '0:00'},
        {'val': 1, 'text': '0:30'},
        {'val': 2, 'text': '1:00'},
        {'val': 3, 'text': '1:30'},
        {'val': 4, 'text': '2:00'},
        {'val': 5, 'text': '2:30'},
        {'val': 6, 'text': '3:00'},
        {'val': 7, 'text': '3:30'},
        {'val': 8, 'text': '4:00'},
        {'val': 9, 'text': '4:30'},
        {'val': 10, 'text': '5:00'},
        {'val': 11, 'text': '5:30'},
        {'val': 12, 'text': '6:00'},
        {'val': 13, 'text': '7:00'},
        {'val': 14, 'text': '7:30'},
        {'val': 15, 'text': '8:00'},
        {'val': 16, 'text': '8:30'},
        {'val': 17, 'text': '9:00'},
        {'val': 18, 'text': '9:30'},
        {'val': 19, 'text': '10:00'},
        {'val': 20, 'text': '10:30'},
        {'val': 21, 'text': '11:00'},
        {'val': 22, 'text': '11:30'},
        {'val': 23, 'text': '12:00'},
        {'val': 24, 'text': '12:30'},
        {'val': 25, 'text': '13:00'},
        {'val': 26, 'text': '13:30'},
        {'val': 27, 'text': '14:00'},
        {'val': 28, 'text': '14:30'},
        {'val': 29, 'text': '15:00'},
        {'val': 30, 'text': '15:30'},
        {'val': 31, 'text': '16:00'},
        {'val': 32, 'text': '16:30'},
        {'val': 33, 'text': '17:00'},
        {'val': 34, 'text': '17:30'},
        {'val': 35, 'text': '18:00'},
        {'val': 36, 'text': '18:30'},
        {'val': 37, 'text': '19:00'},
        {'val': 38, 'text': '19:30'},
        {'val': 39, 'text': '20:00'},
        {'val': 40, 'text': '20:30'},
        {'val': 41, 'text': '21:00'},
        {'val': 42, 'text': '21:30'},
        {'val': 43, 'text': '22:00'},
        {'val': 44, 'text': '22:30'},
        {'val': 45, 'text': '23:00'},
        {'val': 46, 'text': '23:30'},
      ]
    }
  },

  computed: {
    ...mapGetters({
      user: 'auth/user',
      prefs: 'data/prefs',
    }),
    address: function() {
      const pref = this.clinic.pref ? this.clinic.pref.name : ''
      return `${pref}${this.clinic.addr01}${this.clinic.addr02}${this.clinic.department}`;
    },
  },

  mounted() {
    this.getData()
  },

  filters: {
    emptyValue(value) {
      if (value) return value;

      return '未入力';
    }
  },

  methods: {
    getData() {
      this.$store.dispatch('state/setIsLoading')
      axios.get(`/api/clinic/getInfo`)
        .then(res => {
          this.$store.dispatch('state/removeIsLoading')
          this.clinic = res.data.clinic
        })
        .catch(error => {
          this.$store.dispatch('state/removeIsLoading')
        })
    },

    handleEditProfile() {
      this.form = {
        ...this.tmp,
        clinic: { ...this.clinic },
        companyPhotos: [
          ...this.clinic.images.map(el => el.path)
        ],
      }

      this.modalInfo = {
        title: 'プロフィールを編集する',
        confirmBtnTitle: 'クリニック情報を追加'
      }

      this.errors = undefined;
      this.$refs.modal.show();
    },

    handleUpdate() {
      this.$store.dispatch('state/setIsLoading')
      let uploadFlg = false
      if (this.form.avatarFileChanged) {
        uploadFlg = true
        this.$refs.fileUploadComponent.processQueue();
      }
      if (this.form.companyPhotoFileChanged) {
        uploadFlg = true
        this.$refs.multiFilesUploadComponent.processQueue();
      }

      if (!uploadFlg) {
        this.handleSaveClinic()
      }
    },

    handleSaveClinic() {
      console.log(this.form);
      this.$store.dispatch('state/setIsLoading')
      axios.put(`/api/clinic/${this.user.id}`, this.form)
        .then(res => {
          this.$refs.modal.hide();
          this.$swal({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            title: '変更しました。',
            icon: 'success',
          })
          this.clinic = res.data.clinic
          this.$store.dispatch('state/removeIsLoading')
        })
        .catch(error => {
          // this.$refs.modal.hide();
          this.errors = { ...error.response.data.errors }
          this.$store.dispatch('state/removeIsLoading')
        })
    },

    handleFileSaved(fileUrl) {
      this.form.clinic.photo = fileUrl
      this.form.avatarFileChanged = false

      if (!this.form.companyPhotoFileChanged) {
        this.handleSaveClinic()
      }
    },

    hanleFileRemove() {
      this.form.avatarFileChanged = false;
      this.form.clinic.photo = '';
    },

    handleFileAdded(flg) {
      this.form.avatarFileChanged = flg;
    },

    handleMultiFileSaved(fileUrl) {
      this.form.companyPhotos.push(fileUrl)
    },

    hanleMultiFileRemove() {
      let length = this.$refs.multiFilesUploadComponent.getQueuedFiles();
      console.log(length)
      if (!length) {
        this.form.companyPhotoFileChanged = false;
      }
    },

    handleMultiFileAdded(flg) {
      console.log('success')
      this.form.companyPhotoFileChanged = flg;
    },

    handleMultiFilesQueueComplete() {
      console.log('Multi Files Uplaod Complete!');
      this.form.companyPhotoFileChanged = false
      if (!this.form.avatarFileChanged) {
        this.handleSaveClinic()
      }
    },

    handleRemoveFile(index) {
      this.form.companyPhotos.splice(index, 1)
      // this.form.companyPhotoThumbs.splice(index, 1)
    },

    changePref(e) {
      this.cities = [];
      this.towns = [];
      axios.get(`/api/clinic/pref/${this.form.clinic.pref_id}/cities`)
        .then((res) => {
          this.cities = res.data
        });
    },

    changeCity(e) {
      this.towns = [];
      const city_id = this.cities.find(el => el.name == e.target.value).id
      axios.get(`/api/clinic/city/${city_id}/towns`)
        .then((res) => {
          this.towns = res.data
        });
    },

    handleModalClose() {

    },

    selectedStatus01(selected_option,tabindex) {
      if(selected_option!=null){
        this.form.clinic.work_times[tabindex].type=selected_option.val;
      console.log(selected_option);
      }

    },

    selectedAdress(selected_option) {
      console.log(selected_option);
    },

    selectedStartTime(selected_option,tabindex) {
      if(selected_option!=null)
      this.form.clinic.work_times[tabindex].start_time=selected_option.val;
      console.log(selected_option);
    },

    selectedEndTime(selected_option,tabindex) {
      if(selected_option!=null)
      this.form.clinic.work_times[tabindex].end_time=selected_option.val;
      console.log(selected_option);
    },
  }
}
</script>

<style scoped>
  div.create-menu-content{
    padding: 0;
    margin-top: 45px;
  }
  .btn-modal-footer{
    margin-right: 15px;
  }
</style>
