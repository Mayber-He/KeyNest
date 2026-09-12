<script setup lang="ts">
import { computed, useId } from 'vue'

const props = withDefaults(
  defineProps<{
    modelValue?: string
    label?: string
    type?: 'text' | 'email' | 'password' | 'url' | 'search'
    placeholder?: string
    hint?: string
    error?: string
    disabled?: boolean
  }>(),
  {
    modelValue: '',
    label: '',
    type: 'text',
    placeholder: '',
    hint: '',
    error: '',
    disabled: false,
  },
)

const emit = defineEmits<{
  'update:modelValue': [value: string]
}>()

const inputId = useId()
const messageId = `${inputId}-message`
const describedBy = computed(() => (props.error || props.hint ? messageId : undefined))
</script>

<template>
  <label class="app-input">
    <span v-if="label" class="app-input__label">{{ label }}</span>
    <input
      :id="inputId"
      class="app-input__control"
      :class="{ 'app-input__control--error': error }"
      :value="modelValue"
      :type="type"
      :placeholder="placeholder"
      :disabled="disabled"
      :aria-invalid="error ? true : undefined"
      :aria-describedby="describedBy"
      @input="emit('update:modelValue', ($event.target as HTMLInputElement).value)"
    />
    <span v-if="error || hint" :id="messageId" :class="['app-input__message', { 'app-input__message--error': error }]">
      {{ error || hint }}
    </span>
  </label>
</template>

<style scoped>
.app-input {
  display: grid;
  gap: 7px;
}

.app-input__label {
  color: var(--color-text-secondary);
  font-size: 13px;
  font-weight: 560;
}

.app-input__control {
  width: 100%;
  min-height: 44px;
  padding: 10px 12px;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-control);
  background: var(--color-surface);
  color: var(--color-text);
  transition:
    border-color 160ms ease,
    box-shadow 160ms ease;
}

.app-input__control::placeholder {
  color: var(--color-text-muted);
}

.app-input__control:hover:not(:disabled) {
  border-color: #d1d5db;
}

.app-input__control:focus {
  border-color: var(--color-brand);
}

.app-input__control--error {
  border-color: var(--color-danger);
}

.app-input__control:disabled {
  background: var(--color-surface-muted);
  color: var(--color-text-muted);
}

.app-input__message {
  color: var(--color-text-secondary);
  font-size: 12px;
}

.app-input__message--error {
  color: var(--color-danger);
}
</style>
