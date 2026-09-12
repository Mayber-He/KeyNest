<script setup lang="ts">
import { computed, ref, watch } from 'vue'
import AppSidebar from '../../components/AppSidebar.vue'
import VaultItemList from '../../components/VaultItemList.vue'
import { vaultItems } from '../../data/demo-data'
import ProductLayout from '../../layouts/ProductLayout.vue'
import ApiKeyDetail from '../item/ApiKeyDetail.vue'
import LoginDetail from '../item/LoginDetail.vue'

const props = withDefaults(defineProps<{ selectedId?: string }>(), {
  selectedId: 'github-example',
})

const emit = defineEmits<{
  navigate: [url: string]
}>()

const activeId = ref(props.selectedId)
watch(() => props.selectedId, (selectedId) => (activeId.value = selectedId))

const activeItem = computed(() => vaultItems.find((item) => item.id === activeId.value) ?? vaultItems[0])
</script>

<template>
  <ProductLayout>
    <template #sidebar><AppSidebar /></template>
    <template #list>
      <VaultItemList :items="vaultItems" :selected-id="activeItem.id" @select="activeId = $event" />
    </template>
    <ApiKeyDetail v-if="activeItem.kind === 'api-key'" :key="activeItem.id" :item="activeItem" @navigate="emit('navigate', $event)" />
    <LoginDetail v-else :key="activeItem.id" :item="activeItem" @navigate="emit('navigate', $event)" />
  </ProductLayout>
</template>
