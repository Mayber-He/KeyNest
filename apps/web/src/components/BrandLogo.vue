<script setup lang="ts">
withDefaults(
  defineProps<{
    label?: string
    compact?: boolean
  }>(),
  {
    label: 'KeyNest',
    compact: false,
  },
)
</script>

<template>
  <span class="brand-logo" :aria-label="compact ? label : undefined">
    <svg class="brand-logo__mark" viewBox="0 0 32 32" aria-hidden="true">
      <path d="M7 13.5V10a9 9 0 0 1 18 0v3.5" />
      <rect x="4.5" y="12" width="23" height="16" rx="5" />
      <circle cx="16" cy="19" r="2.25" />
      <path class="brand-logo__keyhole" d="M16 21.25V24" />
    </svg>
    <span v-if="!compact" class="brand-logo__wordmark">{{ label }}</span>
  </span>
</template>

<style scoped>
.brand-logo {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  color: var(--color-text);
  font-size: 18px;
  font-weight: 680;
  letter-spacing: -0.02em;
  white-space: nowrap;
}

.brand-logo__mark {
  width: 32px;
  height: 32px;
  flex: none;
  fill: none;
  stroke: currentColor;
  stroke-linecap: round;
  stroke-linejoin: round;
  stroke-width: 1.75;
}

.brand-logo__mark circle,
.brand-logo__keyhole {
  stroke: var(--color-brand);
  stroke-width: 2;
}
</style>
