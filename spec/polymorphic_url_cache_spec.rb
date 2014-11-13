require 'spec_helper'

describe PolymorphicUrlCache do
  before do
    @view = Class.new(ActionView::Base) { include Rails.application.routes.url_helpers }.new
    PolymorphicUrlCache::URL_FOR_CACHE.clear
  end

  describe 'url_for' do
    context 'when an AR object was given' do
      describe 'conferences_path' do
        before do
          @view.url_for(Conference.new)
        end
        specify do
          assert { PolymorphicUrlCache::URL_FOR_CACHE.size == 1 }
          assert { PolymorphicUrlCache::URL_FOR_CACHE.first == [[Conference, nil], "/conferences"] }
        end
      end

      describe 'conference_path' do
        before do
          @conference = Conference.create!
          @view.url_for(@conference)
        end
        specify do
          assert { PolymorphicUrlCache::URL_FOR_CACHE.size == 1 }
          assert { PolymorphicUrlCache::URL_FOR_CACHE.first == [[Conference, @conference.id.to_s], "/conferences/#{@conference.id.to_s}"] }
        end
      end
    end

    context 'when something else than an AR object was given' do
      before do
        @view.url_for('/foo')
      end
      specify do
        assert { PolymorphicUrlCache::URL_FOR_CACHE.size == 0 }
      end
    end
  end
end
