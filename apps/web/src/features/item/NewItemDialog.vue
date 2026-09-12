<script setup lang="ts">
import { computed, nextTick, onBeforeUnmount, onMounted, ref } from 'vue'
import { CircleCheck, KeyRound, LockKeyhole, X } from 'lucide-vue-next'
import AppButton from '../../components/AppButton.vue'
import AppInput from '../../components/AppInput.vue'

type ItemType = 'login' | 'api-key'
type CloseReason = 'dismiss' | 'cancel' | 'saved'

const emit = defineEmits<{
  close: [reason: CloseReason]
}>()

const itemType = ref<ItemType>('login')
const name = ref('')
const account = ref('')
const password = ref('')
const website = ref('')
const apiKey = ref('')
const notes = ref('')
const submitted = ref(false)
const saved = ref(false)
const dialog = ref<HTMLElement | null>(null)
let trigger: HTMLElement | null = null

const nameError = computed(() => submitted.value && !name.value.trim() ? '请输入名称' : '')
const accountError = computed(() => submitted.value && itemType.value === 'login' && !account.value.trim() ? '请输入账号' : '')
const passwordError = computed(() => {
  if (!submitted.value || itemType.value !== 'login') return ''
  if (!password.value) return '请输入密码'
  return password.value.length < 10 ? '密码强度较弱，建议至少使用 10 个字符' : ''
})
const websiteError = computed(() => {
  if (!submitted.value || !website.value) return ''
  try {
    const url = new URL(website.value)
    return ['http:', 'https:'].includes(url.protocol) ? '' : '请输入有效的网址'
  } catch {
    return '请输入有效的网址'
  }
})
const apiKeyError = computed(() => submitted.value && itemType.value === 'api-key' && !apiKey.value.trim() ? '请输入 API Key' : '')

function selectType(type: ItemType) {
  itemType.value = type
  submitted.value = false
}

function focusableElements() {
  return Array.from(
    dialog.value?.querySelectorAll<HTMLElement>(
      'button:not([disabled]), input:not([disabled]), textarea:not([disabled]), select:not([disabled]), [tabindex]:not([tabindex="-1"])',
    ) ?? [],
  )
}

function handleKeydown(event: KeyboardEvent) {
  if (event.key === 'Escape') {
    event.preventDefault()
    emit('close', 'dismiss')
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

function saveItem() {
  submitted.value = true
  const missingRequired = !name.value.trim()
    || (itemType.value === 'login' && (!account.value.trim() || !password.value || password.value.length < 10))
    || (itemType.value === 'api-key' && !apiKey.value.trim())

  if (missingRequired || websiteError.value) return
  saved.value = true
}

onMounted(async () => {
  trigger = document.activeElement instanceof HTMLElement ? document.activeElement : null
  await nextTick()
  focusableElements()[0]?.focus()
})

onBeforeUnmount(() => trigger?.focus())

</script>

<template>
  <main class="new-item-view">
    <section
      ref="dialog"
      class="new-item-dialog"
      role="dialog"
      aria-modal="true"
      aria-labelledby="new-item-title"
      @keydown="handleKeydown"
    >
      <header>
        <div>
          <p>密码库</p>
          <h2 id="new-item-title">新建项目</h2>
        </div>
        <button type="button" aria-label="关闭新建项目窗口" @click="emit('close', 'dismiss')"><X :size="20" aria-hidden="true" /></button>
      </header>

      <div v-if="!saved" class="new-item-dialog__types" role="tablist" aria-label="项目类型">
        <button type="button" role="tab" :aria-selected="itemType === 'login'" @click="selectType('login')">
          <LockKeyhole :size="17" aria-hidden="true" /> 登录账号
        </button>
        <button type="button" role="tab" :aria-selected="itemType === 'api-key'" @click="selectType('api-key')">
          <KeyRound :size="17" aria-hidden="true" /> API Key
        </button>
      </div>

      <form v-if="!saved" novalidate autocomplete="off" @submit.prevent="saveItem">
        <AppInput v-model="name" label="名称" placeholder="例如：GitHub" :error="nameError" />
        <AppInput
          v-if="itemType === 'login'"
          v-model="account"
          label="账号"
          placeholder="用户名或邮箱"
          :error="accountError"
          autocomplete="off"
        />
        <AppInput
          v-if="itemType === 'login'"
          v-model="password"
          label="密码"
          type="password"
          placeholder="输入密码"
          :error="passwordError"
          autocomplete="new-password"
        />
        <AppInput
          v-else
          v-model="apiKey"
          label="API Key"
          type="password"
          placeholder="输入 API Key"
          :error="apiKeyError"
          autocomplete="off"
        />
        <AppInput v-model="website" label="网站（选填）" type="url" placeholder="https://example.com" :error="websiteError" />
        <label class="new-item-dialog__notes">
          <span>备注（选填）</span>
          <textarea v-model="notes" rows="3" placeholder="添加便于识别的信息" />
        </label>

        <footer>
          <AppButton variant="secondary" @click="emit('close', 'cancel')">取消</AppButton>
          <AppButton type="submit">保存项目</AppButton>
        </footer>
      </form>
      <div v-else class="new-item-dialog__saved" role="status">
        <CircleCheck :size="30" aria-hidden="true" />
        <h3>已保存</h3>
        <p>{{ name }} 已添加到当前页面。</p>
        <AppButton @click="emit('close', 'saved')">完成</AppButton>
      </div>
    </section>
  </main>
</template>

<style scoped>
.new-item-view {
  display: grid;
  min-height: 680px;
  padding: 32px 24px;
  place-items: center;
  background: var(--color-surface-subtle);
}

.new-item-dialog {
  width: min(100%, 560px);
  padding: 26px;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-dialog);
  background: var(--color-surface);
  box-shadow: var(--shadow-float);
}

.new-item-dialog header,
.new-item-dialog footer,
.new-item-dialog__types { display: flex; align-items: center; }
.new-item-dialog header { justify-content: space-between; }
.new-item-dialog header p,
.new-item-dialog h2 { margin: 0; }
.new-item-dialog header p { color: var(--color-text-muted); font-size: 12px; font-weight: 650; letter-spacing: .08em; }
.new-item-dialog h2 { margin-top: 4px; font-size: 24px; letter-spacing: -.03em; }
.new-item-dialog header button { display: grid; width: 44px; height: 44px; padding: 0; border: 0; border-radius: 10px; place-items: center; background: transparent; color: var(--color-text-secondary); }

.new-item-dialog__types {
  margin: 22px 0;
  padding: 4px;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-control);
  gap: 4px;
  background: var(--color-surface-subtle);
}

.new-item-dialog__types button {
  display: inline-flex;
  min-height: 44px;
  padding: 0 14px;
  border: 0;
  border-radius: 8px;
  align-items: center;
  gap: 8px;
  flex: 1;
  justify-content: center;
  background: transparent;
  color: var(--color-text-secondary);
}

.new-item-dialog__types button[aria-selected='true'] { background: var(--color-surface); color: var(--color-text); font-weight: 600; }
.new-item-dialog form { display: grid; gap: 16px; }
.new-item-dialog__notes { display: grid; gap: 7px; color: var(--color-text-secondary); font-size: 13px; font-weight: 560; }
.new-item-dialog textarea { min-height: 76px; padding: 10px 12px; resize: vertical; border: 1px solid var(--color-border); border-radius: var(--radius-control); background: var(--color-surface); }
.new-item-dialog footer { padding-top: 6px; justify-content: flex-end; gap: 10px; }
.new-item-dialog__saved { display: grid; min-height: 330px; place-items: center; align-content: center; gap: 10px; text-align: center; }
.new-item-dialog__saved svg { color: var(--color-success); }
.new-item-dialog__saved h3,
.new-item-dialog__saved p { margin: 0; }
.new-item-dialog__saved h3 { font-size: 21px; }
.new-item-dialog__saved p { margin-bottom: 12px; color: var(--color-text-secondary); font-size: 13px; }

@container product-frame (max-width: 719px) {
  .new-item-view { padding: 18px 12px; align-items: start; }
  .new-item-dialog { padding: 22px 18px; }
}
</style>
