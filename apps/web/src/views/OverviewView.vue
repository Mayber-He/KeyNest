<script setup lang="ts">
import { ref } from 'vue'
import { Plus } from 'lucide-vue-next'
import AppButton from '../components/AppButton.vue'
import GalleryShell, {
  type PreviewPage,
  type PreviewViewport,
} from '../components/GalleryShell.vue'
import LoginView from '../features/auth/LoginView.vue'
import UnlockView from '../features/unlock/UnlockView.vue'
import VaultView from '../features/vault/VaultView.vue'
import NewItemDialog from '../features/item/NewItemDialog.vue'
import GeneratorView from '../features/generator/GeneratorView.vue'
import SettingsView from '../features/settings/SettingsView.vue'
import DevicesView from '../features/devices/DevicesView.vue'

const page = ref<PreviewPage>('login')
const viewport = ref<PreviewViewport>('desktop')
const newItemOpen = ref(true)

</script>

<template>
  <GalleryShell v-model:page="page" v-model:viewport="viewport">
    <LoginView v-if="page === 'login'" />
    <UnlockView v-else-if="page === 'unlock'" />
    <VaultView v-else-if="page === 'vault' || page === 'login-detail'" selected-id="github-example" />
    <VaultView v-else-if="page === 'api-key-detail'" selected-id="openai-example" />
    <NewItemDialog v-else-if="page === 'new-item' && newItemOpen" @close="newItemOpen = false" />
    <main v-else-if="page === 'new-item'" class="new-item-closed">
      <Plus :size="28" aria-hidden="true" />
      <h2>新建项目</h2>
      <p>添加登录账号或 API Key。</p>
      <AppButton @click="newItemOpen = true">打开新建项目</AppButton>
    </main>
    <GeneratorView v-else-if="page === 'generator'" />
    <SettingsView v-else-if="page === 'settings'" />
    <DevicesView v-else-if="page === 'devices'" />
  </GalleryShell>
</template>

<style scoped>
.new-item-closed {
  display: grid;
  min-height: 680px;
  padding: 24px;
  place-items: center;
  align-content: center;
  gap: 10px;
  text-align: center;
}

.new-item-closed > svg { color: var(--color-brand); }
.new-item-closed h2,
.new-item-closed p { margin: 0; }
.new-item-closed p { margin-bottom: 12px; color: var(--color-text-secondary); font-size: 13px; }
</style>
