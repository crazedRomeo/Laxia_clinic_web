<template>
  <div v-if="is_master_loaded" class="main-in pd-0">
    <div class="main-content main-dev-content menues-content">
      <div class="staff-header tab-con">
        <p>
          <a
            href="#"
            :class="{ active: query.status == 1 }"
            @click="handleStatusChange(1)"
            >{{ $t("掲載中") }}</a
          >
          <a
            href="#"
            :class="{ active: query.status == 0 }"
            @click="handleStatusChange(0)"
            >{{ $t("掲載停止") }}</a
          >
        </p>
      </div>
      <div class="staff-sub-header">
        <select
          class="menu-sort"
          v-model="m_category"
          :class="{ 'fulled-status': m_category ? 'fulled-input' : '' }"
          @change="handleCategoryChange"
        >
          <option value="-1">{{ $t("施術で絞り込む") }}</option>
          <option
            v-for="item in search_categories"
            :key="item.id"
            :value="item.id"
          >
            {{ item.name }}
          </option>
        </select>
        <button class="btn btn-primary" @click="handleNewMenu">
          <img src="/img/plus.svg" class="img_plus" />
          {{ $t("新規メニューを追加") }}
        </button>
      </div>
      <div class="staff-content">
        <div class="menu-list col-12 px-0">
          <div
            v-for="(item, index) in menus"
            :key="index"
            class="menu-one col-md-6 col-12"
          >
            <div class="menu-one-in" @click="handleShowMenu(item.id)">
              <div class="menu-img">
                <img v-if="item.images.length" :src="item.images[0].path" />
                <!-- <img v-else :src="'/img/menu-img.png'"> -->
              </div>
              <div class="menu-info">
                <template v-for="(item, key) in item.categories" :value="key">
                  <p class="menu-cat" :key="key">
                    {{ item.name }}
                  </p>
                </template>
                <!-- <p v-if="item.category" class="menu-cat">{{ item.category.name }}</p> -->
                <p class="menu-ttl">{{ item.name }}</p>
                <p class="menu-price">
                  {{ item.price | currency }} <span>({{ $t("税込") }})</span>
                </p>
              </div>
            </div>
          </div>
        </div>
        <pagination
          v-if="pageInfo"
          :page="query.page"
          :page-count="pageInfo.last_page"
          :click-handler="handlePaginate"
        />
      </div>
    </div>
    <form-modal
      ref="modal"
      id="menu-modal"
      :title="modalInfo.title"
      @cancel="handleModalClose"
    >
      <!-- <vue-custom-scrollbar class="scroll-modal-body" :settings="settings" @ps-scroll-y="scrollHanle"> -->
      <div class="scroll-modal-body">
        <div v-if="form" class="create-menu-content">
          <div class="form-group">
            <small>{{ $t("掲載ステータス") }}</small>
            <div class="row mx-0">
              <!-- <toggle-button
                v-model="form.menus.status"
                :sync="true"
                :labels="{checked: '掲載', unchecked: '停止'}"
                :color="{checked: '#5CA3F6'}"
                :width="90"
                :height="30"
                :font-size="12" /> -->
              <Toggle
                :defaultState="form.menus.status == 0 ? true : false"
                @change="triggerEvent"
              />
            </div>
          </div>
          <div class="form-group row m-row">
            <div class="col-md-8">
              <small>{{ $t("メニュー名") }}</small>
              <input
                type="text"
                v-model="form.menus.name"
                class="form-control"
                :class="{
                  'is-invalid':
                    errors && errors['menus.name'] && form.menus.name == '',
                  'fulled-status': form.menus.name ? 'fulled-input' : '',
                }"
                placeholder="例：二重切開"
              />
              <!-- <i v-if="errors && errors['menus.name']" class="i-text-invalid bi bi-exclamation-triangle-fill"></i>, 'is-valid' : errors && !errors['menus.name']
              <i v-if="errors && !errors['menus.name']" class="i-text-valid bi bi-check-circle-fill"></i> -->
              <div
                v-if="errors && errors['menus.name']"
                class="error invalid-feedback"
              >
                {{ errors["menus.name"][0] }}
              </div>
            </div>
            <div class="col-md-4">
              <small>{{ $t("料金") }}</small>
              <input
                type="number"
                v-model="form.menus.price"
                class="form-control"
                :class="{
                  'is-invalid':
                    errors && errors['menus.price'] && form.menus.price == '',
                  'fulled-status': form.menus.price ? 'fulled-input' : '',
                }"
                placeholder="例：250000円"
              />
              <!-- <i v-if="errors && errors['menus.price']" class="i-text-invalid bi bi-exclamation-triangle-fill"></i> , 'is-valid' : errors && !errors['menus.price']
              <i v-if="errors && !errors['menus.price']" class="i-text-valid bi bi-check-circle-fill"></i> -->
              <div
                v-if="errors && errors['menus.price']"
                class="error invalid-feedback"
              >
                {{ errors["menus.price"][0] }}
              </div>
            </div>
          </div>

          <div class="form-group row">
            <div class="col-md-12">
              <small>{{ $t("カテゴリー") }}</small>
              <!-- v-model="selected_categories" -->
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
                :class="{
                  'is-invalid':
                    errors &&
                    errors['categories'] &&
                    selected_categories.length == 0,
                }"
              ></multiselect>
              <div
                v-if="
                  errors &&
                  errors['categories'] &&
                  selected_categories.length == 0
                "
                class="error invalid-feedback d-block"
              >
                {{ errors["categories"][0] }}
              </div>
              <div class="view-cate-panel mt-2">
                <template
                  v-for="(item, idx) in selected_categories"
                  :value="id"
                >
                  <p :key="idx">
                    {{ item.group }} / {{ item.name }}
                    <i class="bi bi-x" @click="removeCategory(idx)"></i>
                  </p>
                </template>
              </div>
              <!-- <select v-model="form.menus.category_id" :class="{'is-invalid' : errors && errors['menus.category_id'] }">
                <option></option>
                <optgroup v-for="(parent, id) in categories" :key="id" :label="parent.name">
                  <option v-for="(cate, j) in parent.all_children" :key="j" :value="cate.id">{{ cate.name }}</option>
                </optgroup>
              </select>
              <div v-if="errors && errors['menus.category_id']" class="error invalid-feedback">{{ errors['menus.category_id'][0] }}</div> -->
            </div>
          </div>
          <div class="form-group row companu-content--edit menu-file-upload">
            <div class="col-md-12">
              <small>{{ $t("メニュー画像") }}</small>
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
              <div
                v-if="form.menuPhotos.length"
                class="company-profile-img-list"
              >
                <div
                  v-for="(img, index) in form.menuPhotos"
                  class="company-image--edit"
                  :key="index"
                >
                  <div class="over-hidden">
                    <img :src="img" />
                  </div>
                  <span class="remove-btn" @click="handleRemoveFile(index)">
                    <svg
                      width="12"
                      height="12"
                      viewBox="0 0 12 12"
                      fill="none"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <circle cx="6" cy="6" r="6" fill="#5F6377" />
                      <path
                        d="M8 4L4 8"
                        stroke="white"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                      <path
                        d="M4 4L8 8"
                        stroke="white"
                        stroke-width="2"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      />
                    </svg>
                  </span>
                </div>
              </div>
            </div>
          </div>
          <div class="create-menu-desc">
            <small>{{ $t("メニューの説明") }}</small>
            <textarea
              rows="5"
              v-model="form.menus.description"
              class="form-control"
              :class="{
                'is-invalid':
                  errors &&
                  errors['menus.description'] &&
                  form.menus.description == '',
                'fulled-status': form.menus.description ? 'fulled-input' : '',
              }"
              placeholder="例：この施術は目頭を切る施術になります。"
            ></textarea>
            <div
              v-if="errors && errors['menus.description']"
              class="error invalid-feedback"
            >
              {{ errors["menus.description"][0] }}
            </div>
          </div>
          <div class="create-menu-risk">
            <small>{{ $t("副作用・リスク") }}</small>
            <textarea
              rows="5"
              v-model="form.menus.risk"
              class="form-control"
              :class="{
                'is-invalid':
                  errors && errors['menus.risk'] && form.menus.risk == '',
                'fulled-status': form.menus.risk ? 'fulled-input' : '',
              }"
              placeholder="例：施術後一週間ほど腫れる場合があります。"
            ></textarea>
            <div
              v-if="errors && errors['menus.risk']"
              class="error invalid-feedback"
            >
              {{ errors["menus.risk"][0] }}
            </div>
          </div>
          <div class="create-menu-gurantee">
            <small>{{ $t("施術の保証") }}</small>
            <textarea
              rows="5"
              v-model="form.menus.guarantee"
              class="form-control"
              :class="{
                'is-invalid':
                  errors &&
                  errors['menus.guarantee'] &&
                  form.menus.guarantee == '',
                'fulled-status': form.menus.guarantee ? 'fulled-input' : '',
              }"
              placeholder="例：何日間の保証があります。"
            ></textarea>
            <div
              v-if="errors && errors['menus.guarantee']"
              class="error invalid-feedback"
            >
              {{ errors["menus.guarantee"][0] }}
            </div>
          </div>
          <div class="row create-menu-flow-title">
            <div class="col-9">
              <div>{{ $t(" ") }}</div>
            </div>
            <div class="col-3">
              <div>{{ $t("所要時間") }}</div>
            </div>
          </div>
          <div
            class="form-group row m-row create-menu-flow"
            v-for="(inp, ind) in form.menus.process"
            :key="ind"
          >
            <div class="create-menu-flow-index">{{ ind + 1 }}</div>
            <div class="col-9">
              <div>
                <input type="text" placeholder="例：麻酔" v-model="inp.title" />
              </div>
            </div>
            <div class="col-3">
              <!-- <select class="form-control" :class="{'fulled-status' : form.menus.treat_time ? 'fulled-input': ''}" :key="ind" >
                <option></option>
                  <option v-for="(item, key) in required_time" :key="key" :value="key">{{ item }}</option>
              </select> -->
              <c-enum-select
                :options="required_time"
                :emptyable="true"
                :default="inp.period"
                :tabindex="ind"
                class="select"
                ref="requireTimeSelects"
                @change="selectedRequireTime"
              />
            </div>
          </div>
          <div class="create-menu-flow-increase">
            <img @click="handleClick" src="/img/icons-plus.svg" />
          </div>
          <div class="form-group row m-row">
            <div class="col-6">
              <small>{{ $t("施術時間") }}</small>
              <!-- <select v-model="form.menus.treat_time" class="form-control" :class="{'fulled-status' : form.menus.treat_time ? 'fulled-input': ''}">
                  <option></option>
                  <option v-for="(item, key) in treat_time" :key="key" :value="key">{{ item }}</option>
                </select> -->
              <c-enum-select
                :options="treat_time"
                :emptyable="true"
                :default="form.menus.treat_time"
                class="select"
                ref="timeTreatSelect"
                @change="selectedTimeTreat"
              />
            </div>
            <div class="col-6">
              <small>{{ $t("抜糸") }}</small>
              <!-- <select v-model="form.menus.basshi" class="form-control" :class="{'fulled-status' : form.menus.basshi ? 'fulled-input': ''}">
                  <option></option>
                  <option v-for="(item, key) in basshi" :key="key" :value="key">{{ item }}</option>
                </select> -->
              <c-enum-select
                :options="basshi"
                :emptyable="true"
                :default="form.menus.basshi"
                class="select"
                ref="basshiSelect"
                @change="selectedBasshi"
              />
            </div>
          </div>
          <div class="form-group row m-row">
            <div class="col-6">
              <small>{{ $t("施術後の通院") }}</small>
              <!-- <select v-model="form.menus.hospital_visit" class="form-control" :class="{'fulled-status' : form.menus.hospital_visit ? 'fulled-input': ''}">
                  <option></option>
                  <option v-for="(item, key) in hospital_visit" :key="key" :value="key">{{ item }}</option>
                </select> -->
              <c-enum-select
                :options="hospital_visit"
                :emptyable="true"
                :default="form.menus.hospital_visit"
                class="select"
                ref="hospitalVisitSelect"
                @change="selectedHospitalVisit"
              />
            </div>
            <div class="col-6">
              <small>{{ $t("腫れ") }}</small>
              <!-- <select v-model="form.menus.hare" class="form-control" :class="{'fulled-status' : form.menus.hare ? 'fulled-input': ''}">
                  <option></option>
                  <option v-for="(item, key) in hare" :key="key" :value="key">{{ item }}</option>
                </select> -->
              <c-enum-select
                :options="hare"
                :emptyable="true"
                :default="form.menus.hare"
                class="select"
                ref="hareSelect"
                @change="selectedHare"
              />
            </div>
          </div>
          <div class="form-group row m-row">
            <div class="col-6">
              <small>{{ $t("痛み") }}</small>
              <!-- <select v-model="form.menus.pain" class="form-control" :class="{'fulled-status' : form.menus.pain ? 'fulled-input': ''}">
                  <option></option>
                  <option v-for="(item, key) in pain" :key="key" :value="key">{{ item }}</option>
                </select> -->
              <c-enum-select
                :options="pain"
                :emptyable="true"
                :default="form.menus.pain"
                class="select"
                ref="painSelect"
                @change="selectedPain"
              />
            </div>
            <div class="col-6">
              <small>{{ $t("内出血") }}</small>
              <!-- <select v-model="form.menus.bleeding" class="form-control" :class="{'fulled-status' : form.menus.bleeding ? 'fulled-input': ''}">
                  <option></option>
                  <option v-for="(item, key) in bleeding" :key="key" :value="key">{{ item }}</option>
                </select> -->
              <c-enum-select
                :options="bleeding"
                :emptyable="true"
                :default="form.menus.bleeding"
                class="select"
                ref="bleedingSelect"
                @change="selectedBleeding"
              />
            </div>
          </div>
          <div class="form-group row m-row">
            <div class="col-6">
              <small>{{ $t("入院の必要性") }}</small>
              <!-- <select v-model="form.menus.hospital_need" class="form-control" :class="{'fulled-status' : form.menus.hospital_need ? 'fulled-input': ''}">
                  <option></option>
                  <option v-for="(item, key) in hospital_need" :key="key" :value="key">{{ item }}</option>
                </select> -->
              <c-enum-select
                :options="hospital_need"
                :emptyable="true"
                :default="form.menus.hospital_need"
                class="select"
                ref="hospitalNeedSelect"
                @change="selectedHospitalNeed"
              />
            </div>
            <div class="col-6">
              <small>{{ $t("麻酔") }}</small>
              <!-- <select v-model="form.menus.masui" class="form-control" :class="{'fulled-status' : form.menus.masui ? 'fulled-input': ''}">
                  <option></option>
                  <option v-for="(item, key) in masui" :key="key" :value="key">{{ item }}</option>
                </select> -->
              <c-enum-select
                :options="masui"
                :emptyable="true"
                :default="form.menus.masui"
                class="select"
                ref="masuiSelect"
                @change="selectedMasui"
              />
            </div>
          </div>
          <div class="form-group row m-row">
            <div class="col-6">
              <small>{{ $t("メイク/洗顔") }}</small>
              <!-- <select v-model="form.menus.makeup" class="form-control" :class="{'fulled-status' : form.menus.makeup ? 'fulled-input': ''}">
                  <option></option>
                  <option v-for="(item, key) in makeup" :key="key" :value="key">{{ item }}</option>
                </select> -->
              <c-enum-select
                :options="makeup"
                :emptyable="true"
                :default="form.menus.makeup"
                class="select"
                ref="makeupSelect"
                @change="selectedMakeup"
              />
            </div>
            <div class="col-6">
              <small>{{ $t("シャワー/洗髪/入浴") }}</small>
              <!-- <select v-model="form.menus.shower" class="form-control" :class="{'fulled-status' : form.menus.shower ? 'fulled-input': ''}">
                  <option></option>
                  <option v-for="(item, key) in shower" :key="key" :value="key">{{ item }}</option>
                </select> -->
              <c-enum-select
                :options="shower"
                :emptyable="true"
                :default="form.menus.shower"
                class="select"
                ref="showerSelect"
                @change="selectedShower"
              />
            </div>
          </div>
          <div class="form-group row m-row">
            <div class="col-6">
              <small>{{ $t("施術部のマッサージ") }}</small>
              <!-- <select v-model="form.menus.massage" class="form-control" :class="{'fulled-status' : form.menus.massage ? 'fulled-input': ''}">
                  <option></option>
                  <option v-for="(item, key) in massage" :key="key" :value="key">{{ item }}</option>
                </select> -->
              <c-enum-select
                :options="massage"
                :emptyable="true"
                :default="form.menus.massage"
                class="select"
                ref="massageSelect"
                @change="selectedMassage"
              />
            </div>
            <div class="col-6">
              <small>{{ $t("激しいスポーツ") }}</small>
              <!-- <select v-model="form.menus.sport_impossible" class="form-control" :class="{'fulled-status' : form.menus.sport_impossible ? 'fulled-input': ''}">
                  <option></option>
                  <option v-for="(item, key) in sport_impossible" :key="key" :value="key">{{ item }}</option>
                </select> -->
              <c-enum-select
                :options="sport_impossible"
                :emptyable="true"
                :default="form.menus.sport_impossible"
                class="select"
                ref="sportImpossibleSelect"
                @change="selectedSportImpossible"
              />
            </div>
          </div>
        </div>
      </div>
      <!-- </vue-custom-scrollbar> -->
      <template v-slot:footer>
        <button
          type="button"
          class="btn btn-primary btn-modal-footer"
          @click="handleUpdateMenu"
        >
          {{ modalInfo.confirmBtnTitle }}
        </button>
      </template>
    </form-modal>

    <form-modal ref="viewModal" id="menu-view-modal" :title="modalInfo.title">
      <!-- <vue-custom-scrollbar class="scroll-modal-body" :settings="settings" @ps-scroll-y="scrollHanle"> -->
      <div class="scroll-modal-body">
        <div v-if="form" class="create-menu-content view-modal-content">
          <div class="form-group row">
            <div class="col">
              <small>{{ $t("掲載ステータス") }}</small>
              <p v-if="form.menus.status">{{ $t("掲載中") }}</p>
              <p v-else>{{ $t("停止") }}</p>
            </div>
          </div>
          <div class="form-group row">
            <div class="col-8">
              <small>{{ $t("メニュー名") }}</small>
              <p>{{ form.menus.name }}埋没法ダブル</p>
            </div>
            <div class="col-4">
              <small>{{ $t("料金") }}</small>
              <p>{{ form.menus.price | currency }}</p>
            </div>
          </div>
          <div class="form-group row">
            <div class="col">
              <small>{{ $t("カテゴリー") }}</small>
              <div class="view-cate-panel">
                <template
                  v-for="(item, idx) in selected_categories"
                  :value="id"
                >
                  <p :key="idx">
                    {{ item.name }}
                  </p>
                </template>
              </div>
            </div>
          </div>
          <div class="form-group row">
            <div class="col">
              <small>{{ $t("メニュー画像") }}</small>
              <div class="companu-content--edit">
                <div
                  v-if="form.menuPhotos.length"
                  class="company-profile-img-list"
                >
                  <div
                    v-for="(img, index) in form.menuPhotos"
                    class="company-image--edit"
                    :key="index"
                  >
                    <div class="over-hidden">
                      <img :src="img" />
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="form-group row">
            <div class="col">
              <small>{{ $t("メニューの説明") }}</small>
              <p class="pre-wrap">{{ form.menus.description }}</p>
            </div>
          </div>
          <div class="form-group row">
            <div class="col">
              <small>{{ $t("副作用・リスク") }}</small>
              <p class="pre-wrap">{{ form.menus.risk }}</p>
            </div>
          </div>
          <div class="form-group row">
            <div class="col">
              <small>{{ $t("施術の保証") }}</small>
              <p class="pre-wrap">{{ form.menus.guarantee }}</p>
            </div>
          </div>
          <div class="form-group row result-menu-flow">
            <div>
              <small>{{ $t("施術の流れ") }}</small>
              <span>{{ $t("施術の工程") }}</span>
              <template
                v-for="(item, key) in this.form.menus.process"
                :value="key"
              >
                <div :key="key">
                  <div class="create-menu-flow-index">{{ $t(key + 1) }}</div>
                  <p>{{ item.title }}</p>
                </div>
              </template>
            </div>
            <div>
              <small
                >{{ $t("施術時間") }} {{ this.form.menus.periodsum }}
                {{ $t("分") }}</small
              >
              <span>{{ $t("施術の工程") }}</span>
              <template
                v-for="(item, key) in this.form.menus.process"
                :value="key"
              >
                <p :key="key" style="margin-top: 10px">
                  {{ item.period }}{{ $t("分") }}
                </p>
              </template>
            </div>
          </div>
          <div class="form-group row">
            <div class="col">
              <small>{{ $t("施術時間") }}</small>
              <template v-for="(item, key) in treat_time" :value="key">
                <p v-if="form.menus.treat_time == key" :key="key">
                  {{ item }}
                </p>
              </template>
            </div>
            <div class="col">
              <small>{{ $t("抜糸") }}</small>
              <template v-for="(item, key) in basshi" :value="key">
                <p v-if="form.menus.basshi == key" :key="key">
                  {{ item }}
                </p>
              </template>
            </div>
          </div>
          <div class="form-group row">
            <div class="col">
              <small>{{ $t("施術後の通院") }}</small>
              <template v-for="(item, key) in hospital_visit" :value="key">
                <p v-if="form.menus.hospital_visit == key" :key="key">
                  {{ item }}
                </p>
              </template>
            </div>
            <div class="col">
              <small>{{ $t("腫れ") }}</small>
              <template v-for="(item, key) in hare" :value="key">
                <p v-if="form.menus.hare == key" :key="key">
                  {{ item }}
                </p>
              </template>
            </div>
          </div>
          <div class="form-group row">
            <div class="col">
              <small>{{ $t("痛み") }}</small>
              <template v-for="(item, key) in pain" :value="key">
                <p v-if="form.menus.pain == key" :key="key">
                  {{ item }}
                </p>
              </template>
            </div>
            <div class="col">
              <small>{{ $t("内出血") }}</small>
              <template v-for="(item, key) in bleeding" :value="key">
                <p v-if="form.menus.bleeding == key" :key="key">
                  {{ item }}
                </p>
              </template>
            </div>
          </div>
          <div class="form-group row">
            <div class="col">
              <small>{{ $t("入院の必要性") }}</small>
              <template v-for="(item, key) in hospital_need" :value="key">
                <p v-if="form.menus.hospital_need == key" :key="key">
                  {{ item }}
                </p>
              </template>
            </div>
            <div class="col">
              <small>{{ $t("麻酔") }}</small>
              <template v-for="(item, key) in masui" :value="key">
                <p v-if="form.menus.masui == key" :key="key">
                  {{ item }}
                </p>
              </template>
            </div>
          </div>
          <div class="form-group row">
            <div class="col">
              <small>{{ $t("メイク/洗顔") }}</small>
              <template v-for="(item, key) in makeup" :value="key">
                <p v-if="form.menus.makeup == key" :key="key">
                  {{ item }}
                </p>
              </template>
            </div>
            <div class="col">
              <small>{{ $t("シャワー/洗髪/入浴") }}</small>
              <template v-for="(item, key) in shower" :value="key">
                <p v-if="form.menus.shower == key" :key="key">
                  {{ item }}
                </p>
              </template>
            </div>
          </div>
          <div class="form-group row">
            <div class="col">
              <small>{{ $t("施術部のマッサージ") }}</small>
              <template v-for="(item, key) in massage" :value="key">
                <p v-if="form.menus.massage == key" :key="key">
                  {{ item }}
                </p>
              </template>
            </div>
            <div class="col">
              <small>{{ $t("激しいスポーツ") }}</small>
              <template v-for="(item, key) in sport_impossible" :value="key">
                <p v-if="form.menus.sport_impossible == key" :key="key">
                  {{ item }}
                </p>
              </template>
            </div>
          </div>
        </div>
      </div>
      <!-- </vue-custom-scrollbar> -->
      <template v-slot:footer>
        <div class="view-modal-footer">
          <button
            type="button"
            class="btn btn-danger btn-modal-footer"
            @click="handleDeleteMenu"
          >
            {{ modalInfo.delBtnTitle }}
          </button>
          <button
            type="button"
            class="btn btn-primary btn-modal-footer ml-4"
            @click="handleShowEditMenu"
          >
            {{ modalInfo.confirmBtnTitle }}
          </button>
        </div>
      </template>
    </form-modal>
  </div>
</template>

<script>
import axios from "axios";
import { mapGetters } from "vuex";
import vueCustomScrollbar from "vue-custom-scrollbar";
import "vue-custom-scrollbar/dist/vueScrollbar.css";

export default {
  middleware: "auth",

  components: {
    vueCustomScrollbar,
  },

  data() {
    return {
      menus: [],
      inputGroups: [1],
      form: undefined,
      errors: undefined,
      tmp: {
        menus: {
          name: "",
          speciality_id: "",
          price: "",
          description: "",
          risk: "",
          guarantee: "",
          treat_time: "",
          // required_time: '',
          masui: "",
          hospital_visit: "",
          hare: "",
          pain: "",
          bleeding: "",
          hospital_need: "",
          basshi: "",
          makeup: "",
          shower: "",
          massage: "",
          sport_impossible: "",
          status: true,
          photo: "",
          process: [],
        },
        fileChanged: false,
        menuPhotos: [],
      },
      query: {
        per_page: 10,
        page: 1,
        status: 1,
        speciality_id: "",
      },
      modalInfo: {
        title: "",
        confirmBtnTitle: "",
      },
      pageInfo: undefined,
      selected_categories: [],
      m_category: -1,
      settings: {
        suppressScrollY: false,
        suppressScrollX: true,
        wheelPropagation: false,
      },
      mtb_categories: undefined,
    };
  },

  computed: {
    ...mapGetters({
      token: "auth/token",
      is_master_loaded: "state/is_master_loaded",
      specialities: "data/specialities",
      categories: "data/categories",
      masui: "constant/masui",
      bleeding: "constant/bleeding",
      hospital_need: "constant/hospital_need",
      hospital_visit: "constant/hospital_visit",
      makeup: "constant/makeup",
      massage: "constant/massage",
      pain: "constant/pain",
      shower: "constant/shower",
      sport_impossible: "constant/sport_impossible",
      basshi: "constant/basshi",
      hare: "constant/hare",
      treat_time: "constant/treat_time",
      required_time: "constant/required_time",
    }),

    category_options() {
      return this.categories.map((el) => {
        return {
          group_name: el.name,
          children: el.all_children.map((item) => {
            return {
              id: item.id,
              name: item.name,
            };
          }),
        };
      });
    },

    menu_data() {
      return this.form.menuPhotos;
    },

    search_categories() {
      let tc = [];

      this.categories.map((el) => {
        el.all_children.map((item) => {
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
    handleCateChange(option) {
      let opt_groud_name = "";
      this.category_options.forEach((item) => {
        opt_groud_name = item.group_name;
        item.children.forEach((child) => {
          if (option.id == child.id) {
            if (
              !this.selected_categories
                .map((item) => item.id)
                .includes(child.id)
            ) {
              this.selected_categories.push({
                id: child.id,
                name: child.name,
                group: opt_groud_name,
              });
            }
          }
        });
      });
    },
    removeCategory(idx) {
      this.selected_categories.splice(idx, 1);
    },
    handleClick() {
      this.form.menus.process.push({
        menu_id: this.form.menus.id,
        title: "",
        period: undefined,
      });
    },
    getData() {
      this.$store.dispatch("state/setIsLoading");
      const qs = this.$utils.getQueryString(this.query);
      axios
        .get(`/api/clinic/menus?${qs}`)
        .then((res) => {
          this.menus = res.data.menus.data;

          this.query = {
            ...this.query,
            per_page: res.data.menus.per_page,
          };
          this.pageInfo = {
            last_page: res.data.menus.last_page,
          };
          this.$store.dispatch("state/removeIsLoading");
        })
        .catch((error) => {
          this.$store.dispatch("state/removeIsLoading");
        });
    },

    handleShowMenu(id) {
      let selected = this.menus.find((el) => el.id == id);
      this.form = {
        fileChanged: false,
        menus: {
          id: selected.id,
          name: selected.name,
          category_id: selected.category_id,
          price: selected.price,
          description: selected.description,
          risk: selected.risk,
          guarantee: selected.guarantee,
          treat_time: selected.treat_time,
          // required_time: selected.required_time,
          masui: selected.masui,
          hospital_visit: selected.hospital_visit,
          hare: selected.hare,
          pain: selected.pain,
          bleeding: selected.bleeding,
          hospital_need: selected.hospital_need,
          basshi: selected.basshi,
          makeup: selected.makeup,
          shower: selected.shower,
          massage: selected.massage,
          sport_impossible: selected.sport_impossible,
          status: selected.status == 1,
          photo: selected.photo,
          process: selected.process,
          periodsum: selected.periodsum,
        },
        menuPhotos: selected.images.map((el) => el.path),
      };

      this.selected_categories = [];
      let opt_groud_name;
      this.category_options.forEach((item) => {
        opt_groud_name = item.group_name;
        item.children.forEach((child) => {
          if (selected.categories.map((item) => item.id).includes(child.id)) {
            this.selected_categories.push({
              id: child.id,
              name: child.name,
              group: opt_groud_name,
            });
          }
        });
      });

      // let opt_groud_name;
      // this.category_options.forEach(item => {
      //   opt_groud_name = item.group_name;
      //     item.children.forEach(child => {
      //       if (option.id == child.id) {
      //         if (!this.selected_categories.map(item => item.id).includes(child.id)) {
      //           this.selected_categories.push({
      //             id: child.id,
      //             name: child.name,
      //             group:opt_groud_name
      //           })
      //         }
      //       }
      //     })
      //   })

      // this.modalInfo = {
      //   title: 'メニューを編集',
      //   confirmBtnTitle: 'メニューの編集を完了'
      // }
      // this.$refs.modal.show();
      this.errors = undefined;
      this.modalInfo = {
        title: "メニューの詳細",
        confirmBtnTitle: "メニューを編集",
        delBtnTitle: "メニューを削除",
      };
      this.$refs.viewModal.show();
    },
    handleShowEditMenu() {
      this.modalInfo = {
        title: "メニューを編集",
        confirmBtnTitle: "メニューの編集を完了",
      };
      this.$refs.viewModal.hide();
      if (this.$refs.timeTreatSelect)
        this.$refs.timeTreatSelect.set(this.form.menus.treat_time);
      if (this.$refs.basshiSelect)
        this.$refs.basshiSelect.set(this.form.menus.basshi);
      if (this.$refs.hospitalVisitSelect)
        this.$refs.hospitalVisitSelect.set(this.form.menus.hospital_visit);
      if (this.$refs.hareSelect)
        this.$refs.hareSelect.set(this.form.menus.hare);
      if (this.$refs.painSelect)
        this.$refs.painSelect.set(this.form.menus.pain);
      if (this.$refs.bleedingSelect)
        this.$refs.bleedingSelect.set(this.form.menus.bleeding);
      if (this.$refs.hospitalNeedSelect)
        this.$refs.hospitalNeedSelect.set(this.form.menus.hospital_need);
      if (this.$refs.masuiSelect)
        this.$refs.masuiSelect.set(this.form.menus.masui);
      if (this.$refs.makeupSelect)
        this.$refs.makeupSelect.set(this.form.menus.makeup);
      if (this.$refs.showerSelect)
        this.$refs.showerSelect.set(this.form.menus.shower);
      if (this.$refs.massageSelect)
        this.$refs.massageSelect.set(this.form.menus.massage);
      if (this.$refs.sportImpossibleSelect)
        this.$refs.sportImpossibleSelect.set(this.form.menus.sport_impossible);
      this.$refs.modal.show();
    },

    handleNewMenu() {
      this.form = {
        ...this.tmp,
        menus: { ...this.tmp.menus },
      };
      this.modalInfo = {
        title: "新規メニューを追加",
        confirmBtnTitle: "新規メニューを追加",
      };
      this.form.menuPhotos = [];
      this.selected_categories = [];
      this.errors = undefined;

      this.inputGroups.forEach((val, i) => {
        if (this.$refs.requireTimeSelects && this.$refs.requireTimeSelects[i])
          this.$refs.requireTimeSelects[i].clear();
      });

      if (this.$refs.timeTreatSelect)
        this.$refs.timeTreatSelect.set(this.form.menus.treat_time);
      if (this.$refs.basshiSelect)
        this.$refs.basshiSelect.set(this.form.menus.basshi);
      if (this.$refs.hospitalVisitSelect)
        this.$refs.hospitalVisitSelect.set(this.form.menus.hospital_visit);
      if (this.$refs.hareSelect)
        this.$refs.hareSelect.set(this.form.menus.hare);
      if (this.$refs.painSelect)
        this.$refs.painSelect.set(this.form.menus.pain);
      if (this.$refs.bleedingSelect)
        this.$refs.bleedingSelect.set(this.form.menus.bleeding);
      if (this.$refs.hospitalNeedSelect)
        this.$refs.hospitalNeedSelect.set(this.form.menus.hospital_need);
      if (this.$refs.masuiSelect)
        this.$refs.masuiSelect.set(this.form.menus.masui);
      if (this.$refs.makeupSelect)
        this.$refs.makeupSelect.set(this.form.menus.makeup);
      if (this.$refs.showerSelect)
        this.$refs.showerSelect.set(this.form.menus.shower);
      if (this.$refs.massageSelect)
        this.$refs.massageSelect.set(this.form.menus.massage);
      if (this.$refs.sportImpossibleSelect)
        this.$refs.sportImpossibleSelect.set(this.form.menus.sport_impossible);
      this.$refs.modal.show();
    },
    selectedRequireTime(selected_option, tabindex) {
      this.form.menus.process[tabindex].period = selected_option;
    },

    selectedTimeTreat(selected_option) {
      this.form.menus.treat_time = selected_option;
    },

    selectedBasshi(selected_option) {
      this.form.menus.basshi = selected_option;
    },

    selectedHospitalVisit(selected_option) {
      this.form.menus.hospital_visit = selected_option;
    },

    selectedHare(selected_option) {
      this.form.menus.hare = selected_option;
    },

    selectedPain(selected_option) {
      this.form.menus.pain = selected_option;
    },

    selectedBleeding(selected_option) {
      this.form.menus.bleeding = selected_option;
    },

    selectedHospitalNeed(selected_option) {
      this.form.menus.hospital_need = selected_option;
    },

    selectedMasui(selected_option) {
      this.form.menus.masui = selected_option;
    },

    selectedMakeup(selected_option) {
      this.form.menus.makeup = selected_option;
    },

    selectedShower(selected_option) {
      this.form.menus.shower = selected_option;
    },

    selectedMassage(selected_option) {
      this.form.menus.massage = selected_option;
    },
    handleUpdateMenu() { //pstar
      let flg = false;
      if (this.form.fileChanged) {
        flg = true
        this.$refs.multiFilesUploadComponent.processQueue();
      } else {
        this.handleSaveMenu();
        // this.modalInfo = {
        //   title: 'メニューの詳細',
        //   confirmBtnTitle: 'メニューを編集',
        //   delBtnTitle: 'メニューを削除'
        // }
        // this.$refs.modal.hide();
        // this.$refs.viewModal.show();
      }
    },
    selectedSportImpossible(selected_option) {
      this.form.menus.sport_impossible = selected_option;
    },
    handleSaveMenu() {
      this.$store.dispatch('state/setIsLoading')
      let url = '/api/clinic/menus';
      if (this.form.menus.id) {
        url += `/${this.form.menus.id}`
      }
      this.form = {
        ...this.form,
        categories: this.selected_categories.map(el => el.id)
      }
      axios.post(url, this.form)
        .then(res => {
          let menu = res.data.menu
          this.$store.dispatch('state/removeIsLoading')
          // if (menu.status == 1) {
            this.$store.dispatch('data/addMenu', { menu: menu })
          // }
          this.errors = undefined
          this.$refs.modal.hide()
          this.$swal({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            title: '登録しました。',
            icon: 'success',
          })
          this.getData()
        })
        .catch(error => {
          this.$swal({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            title: '登録できません。',
            icon: 'error',
          })
          this.errors = { ...error.response.data.errors }
          this.$store.dispatch('state/removeIsLoading')
        })
    },
    handleDeleteMenu() {
      this.$refs.viewModal.hide();
      let url = "/api/clinic/menus";
      if (this.form.menus.id) {
        url += `/${this.form.menus.id}`;
      }
      axios
        .delete(url)
        .then((res) => {
          this.getData();
          this.$swal({
            toast: true,
            position: "top-end",
            showConfirmButton: false,
            timer: 3000,
            title: "削除。",
            icon: "success",
          });
        })
        .catch((error) => {
          this.$store.dispatch("state/removeIsLoading");
        });
    },
    handlePaginate(pageNum) {
      this.query = {
        ...this.query,
        page: pageNum,
      }
      this.getData()
    },
    handleModalClose() {
      this.$refs.multiFilesUploadComponent.removeAllFiles();
    },

    // handleFileSaved(fileUrl) {
    //   this.selected_photos.push(fileUrl);
    //   this.form.menus.photo = fileUrl
    //   this.form.fileChanged = false
    //   this.handleSaveMenu()
    // },

    // hanleFileRemove() {
    //   this.form.fileChanged = false;
    //   this.form.menus.photo = '';
    // },

    // handleFileAdded(flg) {
    //   this.form.fileChanged = flg;
    // },

    handleMultiFileSaved(fileUrl) {
      this.form.menuPhotos.push(fileUrl);
    },

    hanleMultiFileRemove(id) {
      let length = this.$refs.multiFilesUploadComponent.getQueuedFiles();
      if (!length) {
        this.form.fileChanged = false;
      }
    },

    handleMultiFileAdded(flg) {
      this.form.fileChanged = flg;
    },

    handleMultiFilesQueueComplete() {
      this.form.fileChanged = false;
      // if (!this.form.avatarFileChanged) {
      console.log(this.form.beforePhotos);
      // this.handleSaveMenu()
      // }
    },

    handleRemoveFile(index) {
      this.form.menuPhotos.splice(index, 1);
    },

    handleCategoryChange(e) {
      e.preventDefault();
      this.query.category_id = e.target.value;
      this.getData();
    },
    triggerEvent(value) {
      if (value) this.form.menus.status = 0;
      else this.form.menus.status = 1;
    },
    scrollHanle(evt) {},
  }
};
</script>

<style scoped>
.img_plus {
  vertical-align: initial;
  margin-right: 5px;
}
.form-group input,
.form-group select {
  height: 50px;
  padding: 3px 12px;
  width: 100%;
}
input::placeholder {
  color: rgba(19, 19, 64, 0.3);
  font-size: 14px;
  font-weight: 500;
}
div.create-menu-content {
  padding: 0;
  margin-top: 45px;
}
.btn-modal-footer {
  font-weight: 500;
}
* >>> .vue-dropzone > .dz-preview .dz-image {
  width: 170px;
}

.view-modal-footer {
  display: flex;
  justify-content: center;
}
.vue-dropzone:hover {
  background-color: #fff !important;
}
.btn-file-upload {
  width: 200px;
  min-width: 200px;
  font-size: 14px;
}

.is-invalid {
  border-color: #dc3545 !important;
}

* >>> .is-invalid .multiselect__tags {
  border-color: #dc3545 !important;
}
* >>> .is-invalid .selected {
  border-color: #dc3545 !important;
}
</style>
