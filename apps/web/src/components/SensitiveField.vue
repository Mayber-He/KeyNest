<script setup lang="ts">
import { ref } from 'vue'
import { Copy, Eye, EyeOff } from 'lucide-vue-next'

const props = defineProps<{
  label: string
  value: string
}>()

const emit = defineEmits<{
  copy: [value: string]
}>()

const revealed = ref(false)
</script>

<template>
  <div class="sensitive-field">
    <span class="sensitive-field__label">{{ label }}</span>
    <div class="sensitive-field__row">
      <code class="sensitive-field__value">{{ revealed ? value : '••••••••••••' }}</code>
      <button
        class="sensitive-field__action"
        type="button"
        :aria-label="`${revealed ? '隐藏' : '显示'} ${label}`"
        @click="revealed = !revealed"
      >
        <EyeOff v-if="revealed" :size="18" aria-hidden="true" />
        <Eye v-else :size="18" aria-hidden="true" />
      </button>
      <button class="sensitive-field__action" type="button" :aria-label="`复制 ${label}`" @click="emit('copy', props.value)">
        <Copy :size="18" aria-hidden="true" />
      </button>
    </div>
  </div>
</template>

<style scoped>
.sensitive-field {
  display: grid;
  gap: 7px;
}

.sensitive-field__label {
  color: var(--color-text-secondary);
  font-size: 13px;
  font-weight: 560;
}

.sensitive-field__row {
  display: flex;
  min-height: 48px;
  align-items: center;
  gap: 2px;
  padding-left: 12px;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-control);
  background: var(--color-surface-muted);
}

.sensitive-field__value {
  min-width: 0;
  flex: 1;
  overflow: hidden;
  color: var(--color-text);
  font-family: var(--font-mono);
  font-size: 13px;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.sensitive-field__action {
  display: inline-grid;
  width: 44px;
  height: 44px;
  flex: none;
  place-items: center;
  border: 0;
  border-radius: var(--radius-sm);
  background: transparent;
  color: var(--color-text-secondary);
  transition:
    background-color 160ms ease,
    color 160ms ease,
    transform 120ms ease;
}

.sensitive-field__action:hover {
  background: var(--color-surface);
  color: var(--color-text);
}

.sensitive-field__action:active {
  transform: scale(0.94);
}

@media (prefers-reduced-motion: reduce) {
  .sensitive-field__action {
    transition: none;
  }

  .sensitive-field__action:active {
    transform: none;
    box-shadow: inset 0 0 0 2px currentColor;
  }
}
</style>
