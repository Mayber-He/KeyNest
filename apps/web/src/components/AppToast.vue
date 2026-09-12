<script setup lang="ts">
import { AlertTriangle, CheckCircle2, Info } from 'lucide-vue-next'

withDefaults(
  defineProps<{
    message: string
    tone?: 'neutral' | 'success' | 'warning'
  }>(),
  {
    tone: 'neutral',
  },
)
</script>

<template>
  <div role="status" :class="['app-toast', `app-toast--${tone}`]">
    <CheckCircle2 v-if="tone === 'success'" :size="18" aria-hidden="true" />
    <AlertTriangle v-else-if="tone === 'warning'" :size="18" aria-hidden="true" />
    <Info v-else :size="18" aria-hidden="true" />
    <span>{{ message }}</span>
  </div>
</template>

<style scoped>
.app-toast {
  display: inline-flex;
  min-height: 44px;
  align-items: center;
  gap: 9px;
  padding: 10px 14px;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-button);
  background: var(--color-surface);
  box-shadow: var(--shadow-float);
  color: var(--color-text);
  font-size: 14px;
}

.app-toast--success svg {
  color: var(--color-success);
}

.app-toast--warning svg {
  color: var(--color-warning);
}

.app-toast--neutral svg {
  color: var(--color-brand);
}
</style>
