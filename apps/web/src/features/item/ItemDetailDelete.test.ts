import { mount, type VueWrapper } from '@vue/test-utils'
import type { Component } from 'vue'
import { vaultItems } from '../../data/demo-data'
import ApiKeyDetail from './ApiKeyDetail.vue'
import LoginDetail from './LoginDetail.vue'

const cases = [
  {
    name: '登录账号',
    component: LoginDetail,
    item: vaultItems.find((item) => item.id === 'github-example')!,
    button: '删除此登录账号',
  },
  {
    name: 'API Key',
    component: ApiKeyDetail,
    item: vaultItems.find((item) => item.id === 'openai-example')!,
    button: '删除此 API Key',
  },
] satisfies ReadonlyArray<{
  name: string
  component: Component
  item: (typeof vaultItems)[number]
  button: string
}>

function buttonByText(wrapper: VueWrapper, text: string) {
  const button = wrapper.findAll('button').find((candidate) => candidate.text() === text)
  if (!button) throw new Error(`找不到按钮：${text}`)
  return button
}

it.each(cases)('$name 删除操作仅在确认后发出事件', async ({ component, item, button }) => {
  const wrapper = mount(component, { props: { item } })

  await buttonByText(wrapper, button).trigger('click')
  expect(wrapper.get('[role="dialog"]').attributes('aria-modal')).toBe('true')
  expect(wrapper.get('[role="dialog"]').text()).toContain('确认删除')

  await buttonByText(wrapper, '取消').trigger('click')
  expect(wrapper.find('[role="dialog"]').exists()).toBe(false)
  expect(wrapper.emitted('delete-confirmed')).toBeUndefined()

  await buttonByText(wrapper, button).trigger('click')
  await buttonByText(wrapper, '确认删除').trigger('click')
  expect(wrapper.find('[role="dialog"]').exists()).toBe(false)
  expect(wrapper.emitted('delete-confirmed')).toEqual([[item.id]])
})
