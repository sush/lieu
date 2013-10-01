require 'spec_helper'

describe Lieu::Client::Photos do
  let(:photo_reference) do
    'CnRtAAAAqCdOEgCrPQY3kaulN3Ywx0CMfg_W97Vfyp5M2tr_qd9HRcodoKvZZhsT_glcV_xJ'\
      'QDM7br-tI2eb9u1cqkyNYEiMvkVLbky4FvheFSvfoqHUDnnJhjzPMxQfFf3GDGnbBmh6aD'\
      'lgSOdd2LNHCm5SNBIQBT5s3kRxjhR0oAnzhINbcxoUyvD_Ce1R79aAormNMM5LhcwFU5w'
  end

  describe '.photo', :vcr do
    it 'returns a photo image' do
      image = client.photo(photo_reference, maxheight: 10)

      expect(image).not_to be_empty
    end
  end
end
