require 'spec_helper'


describe BabelDiff::FileHandler do
  let(:current_version_path) { "path/to/current_file.yml" }
  let(:previous_version_path) {"path/to/current_file.previous_version.yml"}
  let(:updates_path) { "path/to/current_file.updates.yml" }
  let(:additions_path) { "path/to/current_file.additions.yml" }

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
    let(:updates_file) { double(:updates_file) }
    let(:updates_content) { "updates!" }
    before do
      allow(File).to receive(:open).with(updates_path, "w+").and_yield(updates_file)
      allow(updates_file).to receive(:write)
    end
    it "creates a file with the updated keys" do
      file_handler.create_updates(updates_content)
      expect(updates_file).to have_received(:write).with(updates_content)
    end
  end

  describe "#create_additions" do
    let(:additions_file) { double(:additions_file) }
    let(:additions_content) { "additions!" }
    before do
      allow(File).to receive(:open).with(additions_path, "w+").and_yield(additions_file)
      allow(additions_file).to receive(:write)
    end
    it "creates a file with the updated keys" do
      file_handler.create_additions(additions_content)
      expect(additions_file).to have_received(:write).with(additions_content)
    end
  end

  describe "#version_files" do
    let(:previous_version_file) { double(:previous_version_file) }
    let(:current_contents) { "current_contents" }
    before do
      allow(File).to receive(:read).with(current_version_path) { current_contents }
      allow(File).to receive(:open).with(previous_version_path, "w+").and_yield(previous_version_file)
      allow(previous_version_file).to receive(:write)
    end
    
    it "makes a copy of the current file at the version file's location" do
      file_handler.version_files
      expect(previous_version_file).to have_received(:write).with(current_contents)
    end
  end
end
