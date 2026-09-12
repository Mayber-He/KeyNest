<script setup lang="ts">
import { ref } from 'vue'
import { KeyRound } from 'lucide-vue-next'
import GalleryShell, {
  type PreviewPage,
  type PreviewViewport,
} from '../components/GalleryShell.vue'
import LoginView from '../features/auth/LoginView.vue'
import UnlockView from '../features/unlock/UnlockView.vue'
import VaultView from '../features/vault/VaultView.vue'

const page = ref<PreviewPage>('login')
const viewport = ref<PreviewViewport>('desktop')

const remainingPageTitles: Readonly<Partial<Record<PreviewPage, string>>> = {
  'new-item': '新建项目',
  generator: '密码生成器',
  settings: '设置',
  devices: '设备管理',
}
</script>

<template>
  <GalleryShell v-model:page="page" v-model:viewport="viewport">
    <LoginView v-if="page === 'login'" />
    <UnlockView v-else-if="page === 'unlock'" />
    <VaultView v-else-if="page === 'vault' || page === 'login-detail'" selected-id="github-example" />
    <VaultView v-else-if="page === 'api-key-detail'" selected-id="openai-example" />
    <section v-else class="page-placeholder">
      <span class="page-placeholder__mark" aria-hidden="true"><KeyRound :size="25" /></span>
      <p>KeyNest</p>
      <h2>{{ remainingPageTitles[page] }}</h2>
    </section>
  </GalleryShell>
</template>

<style scoped>
.page-placeholder {
  display: flex;
  min-height: 680px;
  padding: 48px 24px;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  text-align: center;
}

.page-placeholder__mark {
  display: grid;
  border: 1px solid var(--color-border);
  place-items: center;
  color: var(--color-brand);
}

.page-placeholder__mark {
  width: 52px;
  height: 52px;
  margin-bottom: 22px;
  border-radius: 15px;
}

.page-placeholder p {
  margin: 0 0 6px;
  color: var(--color-text-muted);
  font-size: 12px;
  font-weight: 650;
  letter-spacing: 0.08em;
  text-transform: uppercase;
}

.page-placeholder h2 {
  margin: 0;
  font-size: clamp(25px, 4vw, 36px);
  letter-spacing: -0.035em;
}

</style>
