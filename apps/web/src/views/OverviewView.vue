<script setup lang="ts">
import { ref } from 'vue'
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

</script>

<template>
  <GalleryShell v-model:page="page" v-model:viewport="viewport">
    <LoginView v-if="page === 'login'" />
    <UnlockView v-else-if="page === 'unlock'" />
    <VaultView v-else-if="page === 'vault' || page === 'login-detail'" selected-id="github-example" />
    <VaultView v-else-if="page === 'api-key-detail'" selected-id="openai-example" />
    <NewItemDialog v-else-if="page === 'new-item'" />
    <GeneratorView v-else-if="page === 'generator'" />
    <SettingsView v-else-if="page === 'settings'" />
    <DevicesView v-else-if="page === 'devices'" />
  </GalleryShell>
</template>
