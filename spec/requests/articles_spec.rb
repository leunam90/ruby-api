require 'rails_helper'

RSpec.describe ArticlesController do 
    describe '#index' do
        it 'return a success response' do
            get '/articles'
            # expect(response.status).to eq(200)
            expect(response).to have_http_status(:ok)
        end

        it 'returns a proper json' do
            article = create :article
            get '/articles'
            #body = json
            #expect(body).to eq(
            expect(json_data.length).to eq(1)
            expected = json_data.first
            aggregate_failures do
                expect(expected[:id]).to eq(article.id.to_s)
                expect(expected[:type]).to eq('article')
                expect(expected[:attributes]).to eq(
                    title: article.title,
                    content: article.content,
                    slug: article.slug
                )
            end
           
            # expect(json_data).to eq(
            #     [
            #         {
            #             id: article.id.to_s,
            #             type: 'article',
            #             attributes: {
            #                 title: article.title,
            #                 content: article.content,
            #                 slug: article.slug
            #             }
            #         }
            #     ]
            # )
        end

        it 'returns articles in the proper order' do 
            older_article = create(:article, created_at: 1.hour.ago)
            recent_article = create(:article)
            
            get '/articles'
            ids = json_data.map { |item| item[:id].to_i }
            expect(ids).to eq([recent_article.id, older_article.id])
        end
    end
end