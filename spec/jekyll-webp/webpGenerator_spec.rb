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

  context "file globbing" do
    let(:files) do
      [
        "file1.txt",
        "img.png",
      ]
    end
    it "looks in a directory for a specified file" do
      allow(Dir).to receive(:glob).and_return(files)

      gen = described_class.new
      gen.set_config(site)
      matched = gen.find_files
      expect(matched).to eq(["img.png"])
    end
    it "filters for extensions"
    it "goes nested"
  end
end
