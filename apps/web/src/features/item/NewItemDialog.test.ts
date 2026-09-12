import { mount } from '@vue/test-utils'
import { nextTick } from 'vue'
import NewItemDialog from './NewItemDialog.vue'

it('emits typed dismiss events from close and cancel actions', async () => {
  const closeWrapper = mount(NewItemDialog)
  await closeWrapper.get('button[aria-label="关闭新建项目窗口"]').trigger('click')
  expect(closeWrapper.emitted('close')).toEqual([['dismiss']])

  const cancelWrapper = mount(NewItemDialog)
  const cancel = cancelWrapper.findAll('button').find((button) => button.text() === '取消')
  expect(cancel).toBeDefined()
  await cancel!.trigger('click')
  expect(cancelWrapper.emitted('close')).toEqual([['cancel']])
})

it('keeps invalid submissions in the form and shows a saved state for valid data', async () => {
  const wrapper = mount(NewItemDialog)

  await wrapper.get('form').trigger('submit')
  expect(wrapper.get('[role="dialog"]').text()).toContain('请输入名称')
  expect(wrapper.find('form').exists()).toBe(true)

  const inputs = wrapper.findAll('input')
  await inputs[0]!.setValue('GitHub')
  await inputs[1]!.setValue('octocat@example.com')
  await inputs[2]!.setValue('correct-horse-battery')
  await inputs[3]!.setValue('https://github.com')
  await wrapper.get('form').trigger('submit')

  expect(wrapper.get('[role="status"]').text()).toContain('已保存')
  expect(wrapper.find('form').exists()).toBe(false)
})

it('focuses the dialog, traps Tab, and dismisses with Escape', async () => {
  const trigger = document.createElement('button')
  document.body.appendChild(trigger)
  trigger.focus()
  const wrapper = mount(NewItemDialog, { attachTo: document.body })
  await nextTick()

  const dialog = wrapper.get('[role="dialog"]')
  const buttons = dialog.findAll<HTMLButtonElement>('button')
  const first = buttons[0]!
  const last = buttons.at(-1)!

  expect(document.activeElement).toBe(first.element)
  last.element.focus()
  await dialog.trigger('keydown', { key: 'Tab' })
  expect(document.activeElement).toBe(first.element)

  await dialog.trigger('keydown', { key: 'Escape' })
  expect(wrapper.emitted('close')).toContainEqual(['dismiss'])

  wrapper.unmount()
  expect(document.activeElement).toBe(trigger)
  trigger.remove()
})
