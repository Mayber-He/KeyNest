<script setup lang="ts">
import { nextTick, onBeforeUnmount, onMounted, ref, useId } from 'vue'
import AppButton from './AppButton.vue'

withDefaults(
  defineProps<{
    title: string
    description: string
    confirmLabel?: string
  }>(),
  {
    confirmLabel: '确认',
  },
)

const emit = defineEmits<{
  cancel: []
  confirm: []
}>()

const dialogId = useId()
const titleId = `${dialogId}-title`
const descriptionId = `${dialogId}-description`
const dialog = ref<HTMLElement | null>(null)
let trigger: HTMLElement | null = null

function focusableElements() {
  return Array.from(
    dialog.value?.querySelectorAll<HTMLElement>(
      'button:not([disabled]), [href], input:not([disabled]), select:not([disabled]), textarea:not([disabled]), [tabindex]:not([tabindex="-1"])',
    ) ?? [],
  )
}

function handleKeydown(event: KeyboardEvent) {
  if (event.key === 'Escape') {
    event.preventDefault()
    emit('cancel')
    return
  }

  if (event.key !== 'Tab') return

  const focusable = focusableElements()
  const first = focusable[0]
  const last = focusable.at(-1)
  if (!first || !last) return

  if (event.shiftKey && document.activeElement === first) {
    event.preventDefault()
    last.focus()
  } else if (!event.shiftKey && document.activeElement === last) {
    event.preventDefault()
    first.focus()
  }
}

onMounted(async () => {
  trigger = document.activeElement instanceof HTMLElement ? document.activeElement : null
  await nextTick()
  focusableElements()[0]?.focus()
})

onBeforeUnmount(() => trigger?.focus())
</script>

<template>
  <div class="confirmation-dialog__backdrop" @click.self="emit('cancel')">
    <section
      ref="dialog"
      class="confirmation-dialog"
      role="dialog"
      aria-modal="true"
      :aria-labelledby="titleId"
      :aria-describedby="descriptionId"
      @keydown="handleKeydown"
    >
      <header>
        <h2 :id="titleId">{{ title }}</h2>
        <p :id="descriptionId">{{ description }}</p>
      </header>
      <footer>
        <AppButton variant="secondary" @click="emit('cancel')">取消</AppButton>
        <AppButton variant="danger" @click="emit('confirm')">{{ confirmLabel }}</AppButton>
      </footer>
    </section>
  </div>
</template>

<style scoped>
.confirmation-dialog__backdrop {
  position: fixed;
  z-index: 1000;
  display: grid;
  inset: 0;
  padding: 24px;
  place-items: center;
  background: rgba(29, 29, 31, 0.18);
}

.confirmation-dialog {
  width: min(100%, 390px);
  padding: 24px;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-dialog);
  background: var(--color-surface);
  box-shadow: var(--shadow-float);
}

.confirmation-dialog header {
  display: grid;
  gap: 8px;
}

.confirmation-dialog h2,
.confirmation-dialog p {
  margin: 0;
}

.confirmation-dialog h2 {
  font-size: 19px;
  letter-spacing: -0.025em;
}

.confirmation-dialog p {
  color: var(--color-text-secondary);
  font-size: 13px;
}

.confirmation-dialog footer {
  display: flex;
  margin-top: 24px;
  justify-content: flex-end;
  gap: 10px;
}
</style>
