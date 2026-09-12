<script setup lang="ts">
import type { ButtonHTMLAttributes } from 'vue'

withDefaults(
  defineProps<{
    type?: ButtonHTMLAttributes['type']
    variant?: 'primary' | 'secondary' | 'ghost' | 'danger'
    disabled?: boolean
  }>(),
  {
    type: 'button',
    variant: 'primary',
    disabled: false,
  },
)
</script>

<template>
  <button :type="type" :class="['app-button', `app-button--${variant}`]" :disabled="disabled">
    <slot />
  </button>
</template>

<style scoped>
.app-button {
  min-width: 44px;
  min-height: 44px;
  padding: 0 16px;
  border: 1px solid transparent;
  border-radius: var(--radius-button);
  background: transparent;
  font-size: 14px;
  font-weight: 600;
  transition:
    background-color 160ms ease,
    border-color 160ms ease,
    color 160ms ease,
    transform 120ms ease;
}

.app-button--primary {
  background: var(--color-brand);
  color: #ffffff;
}

.app-button--primary:hover:not(:disabled) {
  opacity: 0.9;
}

.app-button--secondary {
  border-color: var(--color-border);
  background: var(--color-surface);
  color: var(--color-text);
}

.app-button--secondary:hover:not(:disabled),
.app-button--ghost:hover:not(:disabled) {
  background: var(--color-surface-subtle);
}

.app-button--ghost {
  color: var(--color-text-secondary);
}

.app-button--danger {
  color: var(--color-danger);
}

.app-button--danger:hover:not(:disabled) {
  background: rgba(239, 68, 68, 0.08);
}

.app-button:disabled {
  opacity: 0.48;
}

.app-button:active:not(:disabled) {
  transform: translateY(1px);
}

@media (prefers-reduced-motion: reduce) {
  .app-button {
    transition: none;
  }

  .app-button:active:not(:disabled) {
    transform: none;
    box-shadow: inset 0 0 0 2px currentColor;
  }
}
</style>
