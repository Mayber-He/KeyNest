import { mount } from '@vue/test-utils'
import { vaultItems } from '../../data/demo-data'
import ApiKeyDetail from './ApiKeyDetail.vue'

const openAiItem = vaultItems.find((item) => item.id === 'openai-example')!

it('hides the API key again after leaving the detail view', async () => {
  const wrapper = mount(ApiKeyDetail, { props: { item: openAiItem } })

  expect(wrapper.text()).not.toContain(openAiItem.secret)

  await wrapper.get('button[aria-label="显示 API Key"]').trigger('click')
  expect(wrapper.text()).toContain(openAiItem.secret)

  await wrapper.get('button[aria-label="打开 OpenAI 网站"]').trigger('click')
  expect(wrapper.emitted('navigate')).toEqual([[openAiItem.website]])

  wrapper.unmount()

  const revisited = mount(ApiKeyDetail, { props: { item: openAiItem } })
  expect(revisited.text()).not.toContain(openAiItem.secret)
  expect(revisited.get('button[aria-label="显示 API Key"]').attributes('aria-label')).toBe('显示 API Key')
})
