require 'rails_helper'

RSpec.describe 'Post' do

  describe 'GET /api/posts' do
    it 'lists posts' do
      post = Post.create!(title: 'Foo', tags: [Tag.new(name: 'bar')])

      get api_posts_path(format: 'json')
      expect(response).to be_successful

      json = JSON.parse(response.body)
      expect(json).to be_a(Array)
      expect(json[0]['title']).to eq(post.title)
      expect(json[0]['tags'].count).to eq(post.tags.count)
      expect(json[0]['tags'].first['name']).to eq(post.tags.first.name)
    end
  end

  describe 'GET /api/posts/filter' do
    it 'filter posts or tags by search term' do
      Post.create!(title: 'Test 1', tags: [Tag.new(name: 'Tag 1')])
      Post.create!(title: 'Prova 1', tags: [Tag.new(name: 'Tag 2')])
      Post.create!(title: 'Test 2', tags: [Tag.new(name: 'Tag 3')])
      Post.create!(title: 'Prova 2', tags: [Tag.new(name: 'Tag 3')])
      Post.create!(title: 'Prova 3', tags: [Tag.new(name: 'Tag 2')])
      Post.create!(title: 'Prova 4', tags: [Tag.new(name: 'Tag 2')])
      
      get api_posts_filter_path(format: 'json', params: { term: "Prova" })
      expect(response).to be_successful
      json = JSON.parse(response.body)
      expect(json).to be_a(Array)
      expect(json.length).to eq(4)

      get api_posts_filter_path(format: 'json', params: { term: "3" })
      expect(response).to be_successful
      json = JSON.parse(response.body)
      expect(json).to be_a(Array)
      expect(json.length).to eq(3)

      get api_posts_filter_path(format: 'json', params: { term: "" })
      expect(response).to be_successful
      json = JSON.parse(response.body)
      expect(json).to be_a(Array)
      expect(json.length).to eq(6)
    end
  end
end
