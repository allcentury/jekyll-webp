require 'spec_helper'

RSpec.describe Jekyll::Webp::WebpGenerator do
  let(:img_dir) do
    "./spec/imgs"
  end
  let(:site) do
    instance_double(Jekyll::Site,
                    source: ".",
                    dest: "./tmp/_site/",
                    config: {
                      'webp' => {
                        'enabled' => true,
                        'img_dir' => [img_dir],
                        'regenerate' => true,
                      }
                    },
                    static_files: [],
                   )
  end
  context "process_img" do
    it "runs" do
      described_class.new.generate(site)
    end
  end
end
