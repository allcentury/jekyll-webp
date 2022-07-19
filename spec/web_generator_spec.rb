require 'spec_helper'

describe Jekyll::Webp do
  let(:config) do
    Jekyll::Configuration.from(YAML.load(File.read("spec/fixtures/webp_config.yml")))
  end
  it "renders multiple files when quality has only one value" do
    site = instance_double(Jekyll::Site, config: config, dest: "/tmp", source: ".", static_files: [])

    expect(Jekyll::Webp::WebpExec).to receive(:run) do |quality, flags, file, output_file|
      expect(quality).to eq(75)
      expect(flags). to eq("-m 4 -pass 4 -af")
      expect(file).to eq("./spec/fixtures/images/james_webb.jpg")
      expect(output_file).to eq("/tmp/spec/fixtures/images/james_webb-75.webp")
    end
    generator = Jekyll::Webp::WebpGenerator.new

    generator.generate(site)
  end

  it "renders multiple files when quality is an array" do
    config["webp"]["quality"] = [75, 25]
    site = instance_double(Jekyll::Site, config: config, dest: "/tmp", source: ".", static_files: [])

    expect(Jekyll::Webp::WebpExec).to receive(:run).with(75, /.*/, include("james_webb"), include("-75.webp")).once
    expect(Jekyll::Webp::WebpExec).to receive(:run).with(25, /.*/, include("james_webb"), include("-25.webp")).once
    generator = Jekyll::Webp::WebpGenerator.new

    generator.generate(site)
  end
end

