<template>
  <div class="sidebar">
		<h1 class="logo">
			<router-link :to="{ name: 'reservations' }">
				<svg width="98" height="26" viewBox="0 0 98 26" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path d="M0.168 0.512H3.192V23.192H14.856V26H0.168V0.512ZM26.448 0.512H29.292L40.128 26H36.6L34.008 19.736H21.264L18.636 26H15.216L26.448 0.512ZM27.816 4.4H27.744L22.452 16.928H32.856L27.816 4.4ZM49.5277 12.572L40.9597 0.512H44.8477L51.7237 10.484L58.5277 0.512H62.3077L53.7397 12.572L63.1357 26H59.1397L51.5797 14.696L43.9837 26H40.2397L49.5277 12.572ZM66.1914 0.512H69.2154V26H66.1914V0.512ZM83.823 0.512H86.667L97.503 26H93.975L91.383 19.736H78.639L76.011 26H72.591L83.823 0.512ZM85.191 4.4H85.119L79.827 16.928H90.231L85.191 4.4Z" fill="#5F6377"/>
				</svg>				
			</router-link>
		</h1>
		<div class="menu">
			<ul class="sidebar-menu-list">
				<li>
					<router-link :to="{ name: 'reservations' }" active-class="active">
						<p>
							<!-- <svg width="16" height="20" viewBox="0 0 16 20" fill="none" xmlns="http://www.w3.org/2000/svg">
								<path d="M9.66665 1.66666H2.99998C2.55795 1.66666 2.13403 1.84225 1.82147 2.15481C1.50891 2.46737 1.33331 2.8913 1.33331 3.33332V16.6667C1.33331 17.1087 1.50891 17.5326 1.82147 17.8452C2.13403 18.1577 2.55795 18.3333 2.99998 18.3333H13C13.442 18.3333 13.8659 18.1577 14.1785 17.8452C14.4911 17.5326 14.6666 17.1087 14.6666 16.6667V6.66666L9.66665 1.66666Z" stroke="#728396" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/><path d="M9.66669 1.66666V6.66666H14.6667" stroke="#728396" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/><path d="M11.3334 10.8333H4.66669" stroke="#728396" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/><path d="M11.3334 14.1667H4.66669" stroke="#728396" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/><path d="M6.33335 7.5H5.50002H4.66669" stroke="#728396" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
							</svg> -->
							<i class="far fa-file-alt"></i>
						</p>
						<span>{{ $t('予約') }}</span>
					</router-link>
				</li>
				<li>
					<router-link :to="{ name: 'payments' }" active-class="active">
						<p>
							<!-- <svg width="12" height="20" viewBox="0 0 12 20" fill="none" xmlns="http://www.w3.org/2000/svg">
								<path d="M6 0.833344V19.1667" stroke="#728396" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/><path d="M10.1667 4.16666H3.91667C3.14312 4.16666 2.40125 4.47395 1.85427 5.02093C1.30729 5.56791 1 6.30978 1 7.08332C1 7.85687 1.30729 8.59874 1.85427 9.14572C2.40125 9.6927 3.14312 9.99999 3.91667 9.99999H8.08333C8.85688 9.99999 9.59875 10.3073 10.1457 10.8543C10.6927 11.4012 11 12.1431 11 12.9167C11 13.6902 10.6927 14.4321 10.1457 14.9791C9.59875 15.526 8.85688 15.8333 8.08333 15.8333H1" stroke="#728396" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
							</svg> -->
							<i class="fas fa-dollar-sign"></i>							
						</p>						
						<span>{{ $t('決済') }}</span>
					</router-link>
				</li>
				<li>
					<router-link :to="{ name: 'history' }" active-class="active">
						<p>
							<svg width="20" height="12" viewBox="0 0 20 12" fill="none" xmlns="http://www.w3.org/2000/svg">
								<path d="M19.1666 1L11.25 8.91667L7.08331 4.75L0.833313 11" stroke="#728396" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/><path d="M14.1667 1H19.1667V6" stroke="#728396" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
							</svg>
							<!-- <i class="fas fa-chart-line"></i> -->
						</p>
						<span>{{ $t('会計') }}</span>
					</router-link>
				</li>
				<!-- <li>
					<router-link :to="{ name: 'patients' }" active-class="active">
						<p>
							<svg width="16" height="18" viewBox="0 0 16 18" fill="none" xmlns="http://www.w3.org/2000/svg">
								<path d="M14.6666 16.5V14.8333C14.6666 13.9493 14.3155 13.1014 13.6903 12.4763C13.0652 11.8512 12.2174 11.5 11.3333 11.5H4.66665C3.78259 11.5 2.93474 11.8512 2.30962 12.4763C1.6845 13.1014 1.33331 13.9493 1.33331 14.8333V16.5" stroke="#728396" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/><path d="M8.00002 8.16667C9.84097 8.16667 11.3334 6.67428 11.3334 4.83333C11.3334 2.99238 9.84097 1.5 8.00002 1.5C6.15907 1.5 4.66669 2.99238 4.66669 4.83333C4.66669 6.67428 6.15907 8.16667 8.00002 8.16667Z" stroke="#728396" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
							</svg>
						</p>
						<span>{{ $t('患者') }}</span>
					</router-link>
				</li> -->
				<li>
					<router-link :to="{ name: 'clinic' }" active-class="active">
						<p>
							<!-- <svg width="19" height="20" viewBox="0 0 19 20" fill="none" xmlns="http://www.w3.org/2000/svg">
								<path d="M17.8667 9.20835L10.2084 16.8667C9.27017 17.8049 7.99769 18.332 6.67087 18.332C5.34405 18.332 4.07157 17.8049 3.13337 16.8667C2.19517 15.9285 1.66809 14.656 1.66809 13.3292C1.66809 12.0024 2.19517 10.7299 3.13337 9.79168L10.7917 2.13335C11.4172 1.50788 12.2655 1.15649 13.15 1.15649C14.0346 1.15649 14.8829 1.50788 15.5084 2.13335C16.1338 2.75882 16.4852 3.60713 16.4852 4.49168C16.4852 5.37623 16.1338 6.22455 15.5084 6.85002L7.8417 14.5083C7.52897 14.8211 7.10481 14.9968 6.66254 14.9968C6.22026 14.9968 5.79611 14.8211 5.48337 14.5083C5.17064 14.1956 4.99494 13.7715 4.99494 13.3292C4.99494 12.8869 5.17064 12.4627 5.48337 12.15L12.5584 5.08335" stroke="#728396" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
							</svg> -->
							<!-- <i class="fas fa-paperclip"></i> -->
							<i class="far fa-hospital"></i>
						</p>
						<span>{{ $t('クリニック') }}</span>
					</router-link>
				</li>
				<li>
					<router-link :to="{ name: 'doctors' }" active-class="active">
						<p>
							<!-- <svg width="14" height="20" viewBox="0 0 14 20" fill="none" xmlns="http://www.w3.org/2000/svg">
								<path d="M7.00002 12.5C10.2217 12.5 12.8334 9.88832 12.8334 6.66666C12.8334 3.445 10.2217 0.833328 7.00002 0.833328C3.77836 0.833328 1.16669 3.445 1.16669 6.66666C1.16669 9.88832 3.77836 12.5 7.00002 12.5Z" stroke="#728396" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/><path d="M3.84165 11.575L2.83331 19.1667L6.99998 16.6667L11.1666 19.1667L10.1583 11.5667" stroke="#728396" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
							</svg> -->
							<i class="fas fa-user-md"></i>
						</p>
						<span>{{ $t('メンバー') }}</span>
					</router-link>
				</li>
				<li>
					<router-link :to="{ name: 'menus' }" active-class="active">
						<p>
							<svg width="19" height="19" viewBox="0 0 19 19" fill="none" xmlns="http://www.w3.org/2000/svg">
								<path d="M17.1584 11.175L11.1834 17.15C11.0286 17.305 10.8448 17.4279 10.6424 17.5118C10.4401 17.5956 10.2232 17.6388 10.0042 17.6388C9.78516 17.6388 9.56828 17.5956 9.36595 17.5118C9.16362 17.4279 8.97981 17.305 8.82502 17.15L1.66669 10V1.66667H10L17.1584 8.82501C17.4688 9.13728 17.643 9.5597 17.643 10C17.643 10.4403 17.4688 10.8627 17.1584 11.175V11.175Z" stroke="#728396" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/><path d="M5.83331 5.83334H5.84165" stroke="#728396" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
							</svg>
						</p>
						<span>{{ $t('メニュー') }}</span>
					</router-link>
				</li>
				<li>
					<router-link :to="{ name: 'cases' }" active-class="active">
						<p>
							<i class="far fa-images"></i>
						</p>
						<span>{{ $t('症例') }}</span>
					</router-link>
				</li>
				<li>
					<router-link :to="{ name: 'billing' }" active-class="active">
						<p>
							<i class="far fa-file-alt"></i>
						</p>
						<span>{{ $t('請求') }}</span>
					</router-link>
				</li>
			</ul>
		</div>
	</div>
</template>

<script>
import { mapGetters } from 'vuex'
import LocaleDropdown from './LocaleDropdown'

export default {
  components: {
    LocaleDropdown
  },

  data: () => ({
    appName: window.config.appName
  }),

  computed: mapGetters({
    user: 'auth/user'
  }),

  methods: {
  }
}
</script>

<style scoped>
.profile-photo {
  width: 2rem;
  height: 2rem;
  margin: -.375rem 0;
}
</style>
