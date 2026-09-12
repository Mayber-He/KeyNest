<script setup lang="ts">
import { onBeforeUnmount, ref } from 'vue'
import { ExternalLink, ShieldCheck } from 'lucide-vue-next'
import AppToast from '../../components/AppToast.vue'
import ConfirmationDialog from '../../components/ConfirmationDialog.vue'
import SensitiveField from '../../components/SensitiveField.vue'
import type { VaultItem } from '../../data/demo-data'

const props = defineProps<{ item: VaultItem }>()

const emit = defineEmits<{
  navigate: [url: string]
  'delete-confirmed': [id: string]
}>()

const copied = ref(false)
const confirmingDelete = ref(false)
let copiedTimer: ReturnType<typeof setTimeout> | undefined

function showCopied() {
  copied.value = true
  clearTimeout(copiedTimer)
  copiedTimer = setTimeout(() => (copied.value = false), 1800)
}

function confirmDelete() {
  confirmingDelete.value = false
  emit('delete-confirmed', props.item.id)
}

onBeforeUnmount(() => clearTimeout(copiedTimer))
</script>

<template>
  <article class="item-detail">
    <header class="item-detail__header">
      <span class="item-detail__mark" aria-hidden="true"><ShieldCheck :size="22" /></span>
      <div>
        <p>登录账号</p>
        <h2>{{ item.name }}</h2>
      </div>
      <button class="item-detail__edit" type="button">编辑</button>
    </header>

    <dl class="item-detail__fields">
      <div><dt>账号</dt><dd>{{ item.account }}</dd></div>
      <div><dt>密码</dt><dd><SensitiveField label="密码" :value="item.secret" @copy="showCopied" /></dd></div>
      <div>
        <dt>网站</dt>
        <dd>
          <button type="button" :aria-label="`打开 ${item.name} 网站`" @click="emit('navigate', item.website)">
            {{ item.website }} <ExternalLink :size="15" aria-hidden="true" />
          </button>
        </dd>
      </div>
      <div><dt>最近更新</dt><dd>{{ item.updatedAt }}</dd></div>
    </dl>

    <button class="item-detail__delete" type="button" @click="confirmingDelete = true">删除此登录账号</button>
    <AppToast v-if="copied" class="item-detail__toast" message="已复制" tone="success" />
    <ConfirmationDialog
      v-if="confirmingDelete"
      title="确认删除"
      :description="`确定要删除 ${item.name} 登录账号吗？此操作仅触发界面事件。`"
      confirm-label="确认删除"
      @cancel="confirmingDelete = false"
      @confirm="confirmDelete"
    />
  </article>
</template>

<style scoped>
.item-detail {
  position: relative;
  min-height: 680px;
  padding: 42px clamp(24px, 5vw, 58px);
}

.item-detail__header {
  display: grid;
  padding-bottom: 30px;
  border-bottom: 1px solid var(--color-border);
  grid-template-columns: 48px minmax(0, 1fr) auto;
  align-items: center;
  gap: 16px;
}

.item-detail__mark {
  display: grid;
  width: 48px;
  height: 48px;
  border: 1px solid var(--color-border);
  border-radius: 13px;
  place-items: center;
  color: var(--color-brand);
}

.item-detail__header p,
.item-detail__header h2 {
  margin: 0;
}

.item-detail__header p {
  margin-bottom: 5px;
  color: var(--color-text-muted);
  font-size: 12px;
  font-weight: 650;
  letter-spacing: 0.08em;
}

.item-detail__header h2 {
  font-size: 24px;
  letter-spacing: -0.025em;
}

.item-detail__edit,
.item-detail__delete,
.item-detail__fields button {
  min-height: 44px;
  border: 0;
  background: transparent;
}

.item-detail__edit {
  padding: 0 10px;
  color: var(--color-text-secondary);
}

.item-detail__fields {
  display: grid;
  margin: 30px 0 36px;
  gap: 24px;
}

.item-detail__fields > div {
  display: grid;
  gap: 7px;
}

.item-detail__fields dt {
  color: var(--color-text-secondary);
  font-size: 12px;
}

.item-detail__fields dd {
  margin: 0;
  overflow-wrap: anywhere;
  font-size: 14px;
}

.item-detail__fields button {
  display: inline-flex;
  max-width: 100%;
  padding: 0;
  align-items: center;
  gap: 7px;
  color: var(--color-text);
  font-family: var(--font-mono);
  text-align: left;
  overflow-wrap: anywhere;
}

.item-detail__delete {
  padding: 0;
  color: #b42318;
  font-size: 13px;
}

.item-detail__toast {
  position: absolute;
  right: 24px;
  bottom: 24px;
}

@container product-frame (max-width: 719px) {
  .item-detail {
    padding: 28px 22px;
  }
}
</style>
