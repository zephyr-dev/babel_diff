require 'spec_helper'

describe BabelDiff::FileHandler do
  let(:current_version_path) { "path/to/current_file.yml" }
  let(:previous_version_path) {"path/to/current_file.previous_version.yml"}
  subject(:file_handler) { BabelDiff::FileHandler.new(current_version_path) }

  describe "#current_version" do
    before do
      allow(File).to receive(:exist?).with(current_version_path) { file_exists }
    end
    context "when a versioned file exists" do
      let(:file_exists) { true }
      let(:current_version_contents) { "contents" }
      before do
        allow(File).to receive(:read).with(current_version_path){current_version_contents}
      end

      specify{ expect(file_handler.current_version).to eq(current_version_contents) }
    end

    context "when no versioned file exists" do
      let(:file_exists) { false }
      specify{ expect { file_handler.current_version }.to raise_error("Phrase file not found") }
    end

  end
  describe "#previous_version" do
    before do
      allow(File).to receive(:exist?).with(previous_version_path) { file_exists }
    end
    context "when a versioned file exists" do
      let(:file_exists) { true }
      let(:previous_version_contents) { "contents" }
      before do
        allow(File).to receive(:read).with(previous_version_path){previous_version_contents}
      end

      specify{ expect(file_handler.previous_version).to eq(previous_version_contents) }
    end

    context "when no versioned file exists" do
      let(:file_exists) { false }
      specify{ expect(file_handler.previous_version).to eq("") }
    end

  end

  describe "#create_updates" do

  end

  describe "#create_additions" do

  end

  describe "#version_current_file" do

  end
end
