<script setup lang="ts">
import { CircleCheck, LoaderCircle, TriangleAlert, WifiOff } from 'lucide-vue-next'
import { computed } from 'vue'

export type SyncState = 'synced' | 'syncing' | 'offline' | 'conflict'

const props = withDefaults(defineProps<{ state?: SyncState }>(), {
  state: 'synced',
})

const presentation = computed(() => ({
  synced: { label: '已同步', icon: CircleCheck },
  syncing: { label: '正在同步', icon: LoaderCircle },
  offline: { label: '当前离线', icon: WifiOff },
  conflict: { label: '检测到同步冲突', icon: TriangleAlert },
})[props.state])
</script>

<template>
  <span :class="['sync-status', `sync-status--${state}`]" role="status">
    <component :is="presentation.icon" :size="15" aria-hidden="true" />
    {{ presentation.label }}
  </span>
</template>

<style scoped>
.sync-status {
  display: inline-flex;
  min-height: 44px;
  align-items: center;
  gap: 7px;
  color: var(--color-text-secondary);
  font-size: 12px;
}

.sync-status--synced { color: #237a45; }
.sync-status--syncing { color: #315fbb; }
.sync-status--offline { color: var(--color-text-secondary); }
.sync-status--conflict { color: #9a5b0b; }

.sync-status--syncing :deep(svg) {
  animation: sync-status-spin 1.2s linear infinite;
}

@keyframes sync-status-spin {
  to { transform: rotate(360deg); }
}

@media (prefers-reduced-motion: reduce) {
  .sync-status--syncing :deep(svg) { animation: none; }
}
</style>
