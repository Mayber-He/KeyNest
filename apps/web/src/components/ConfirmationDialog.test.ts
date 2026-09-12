import { mount } from '@vue/test-utils'
import { defineComponent, nextTick, ref } from 'vue'
import ConfirmationDialog from './ConfirmationDialog.vue'

const DialogHarness = defineComponent({
  components: { ConfirmationDialog },
  setup() {
    const open = ref(false)
    return { open }
  },
  template: `
    <button type="button" data-trigger @click="open = true">删除项目</button>
    <ConfirmationDialog
      v-if="open"
      title="确认删除"
      description="此操作无法撤销。"
      confirm-label="确认删除"
      @cancel="open = false"
      @confirm="open = false"
    />
  `,
})

it('traps keyboard focus, closes with Escape, and restores the trigger focus', async () => {
  const wrapper = mount(DialogHarness, { attachTo: document.body })
  const trigger = wrapper.get<HTMLButtonElement>('[data-trigger]')

  trigger.element.focus()
  await trigger.trigger('click')
  await nextTick()

  const dialog = wrapper.get('[role="dialog"]')
  const buttons = dialog.findAll<HTMLButtonElement>('button')
  const cancel = buttons[0]!
  const confirm = buttons[1]!

  expect(document.activeElement).toBe(cancel.element)

  confirm.element.focus()
  await dialog.trigger('keydown', { key: 'Tab' })
  expect(document.activeElement).toBe(cancel.element)

  cancel.element.focus()
  await dialog.trigger('keydown', { key: 'Tab', shiftKey: true })
  expect(document.activeElement).toBe(confirm.element)

  await dialog.trigger('keydown', { key: 'Escape' })
  await nextTick()

  expect(wrapper.find('[role="dialog"]').exists()).toBe(false)
  expect(document.activeElement).toBe(trigger.element)

  wrapper.unmount()
})
