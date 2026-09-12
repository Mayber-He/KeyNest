<script setup lang="ts">
import { KeyRound, Search, ShieldCheck } from 'lucide-vue-next'
import type { VaultItem } from '../data/demo-data'

defineProps<{
  items: readonly VaultItem[]
  selectedId?: string
}>()

const emit = defineEmits<{
  select: [id: string]
}>()
</script>

<template>
  <section class="vault-list" aria-label="密码库项目">
    <header>
      <h2>密码库</h2>
      <button type="button" aria-label="搜索">
        <Search :size="18" aria-hidden="true" />
      </button>
    </header>
    <div class="vault-list__items">
      <button
        v-for="item in items"
        :key="item.id"
        type="button"
        :class="{ 'vault-list__item--active': selectedId === item.id }"
        :aria-pressed="selectedId === item.id"
        @click="emit('select', item.id)"
      >
        <span class="vault-list__icon">
          <KeyRound v-if="item.kind === 'api-key'" :size="18" aria-hidden="true" />
          <ShieldCheck v-else :size="18" aria-hidden="true" />
        </span>
        <span class="vault-list__copy">
          <strong>{{ item.name }}</strong>
          <small>{{ item.account }}</small>
        </span>
        <time>{{ item.updatedAt }}</time>
      </button>
    </div>
  </section>
</template>

<style scoped>
.vault-list {
  min-width: 0;
  border-right: 1px solid var(--color-border);
  background: var(--color-surface);
}

.vault-list header {
  display: flex;
  height: 76px;
  padding: 0 22px;
  border-bottom: 1px solid var(--color-border);
  align-items: center;
  justify-content: space-between;
}

.vault-list h2 {
  margin: 0;
  font-size: 18px;
  letter-spacing: -0.02em;
}

.vault-list header button {
  display: grid;
  width: 44px;
  height: 44px;
  border: 0;
  border-radius: 9px;
  place-items: center;
  background: transparent;
  color: var(--color-text-secondary);
}

.vault-list header button:hover {
  background: var(--color-surface-subtle);
}

.vault-list__items {
  padding: 9px;
}

.vault-list__item {
  display: grid;
  width: 100%;
  min-height: 68px;
  padding: 10px;
  border: 0;
  border-radius: 10px;
  grid-template-columns: 38px minmax(0, 1fr) auto;
  align-items: center;
  gap: 10px;
  background: transparent;
  text-align: left;
}

.vault-list__item:hover,
.vault-list__item--active {
  background: var(--color-surface-subtle);
}

.vault-list__icon {
  display: grid;
  width: 36px;
  height: 36px;
  border: 1px solid var(--color-border);
  border-radius: 10px;
  place-items: center;
  color: var(--color-brand);
}

.vault-list__copy {
  display: grid;
  min-width: 0;
  gap: 3px;
}

.vault-list__copy strong,
.vault-list__copy small {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.vault-list__copy strong {
  font-size: 13px;
}

.vault-list__copy small,
.vault-list time {
  color: var(--color-text-secondary);
  font-size: 11px;
}
</style>
