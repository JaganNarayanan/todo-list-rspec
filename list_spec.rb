require "rspec"

require_relative "list"
require_relative "task"

describe List do
  # Defining some variables to be used later.
  let(:title) { "Today's tasks" }
  let(:task1) {Task.new("Task1")}
  let(:task2) {Task.new("Task2")}
  let(:task3) {Task.new("Task3")}
  let(:list1) {List.new(title, [task1, task2, task3])}

  describe "#initialize" do

    context "input has to be valid" do
      it "takes a description as its first argument" do
        expect(List.new(title)).to be_an_instance_of(List)
      end

      it "requires one argument" do
        expect {List.new}.to raise_error(ArgumentError)
      end

      # it "accepts only string as title" do
      #   expect {List.new(1)}.to raise_error(ArgumentError)
      #   expect {List.new(["string but inside array"])}.to raise_error(ArgumentError)
      #   expect {List.new{"string but inside lamdha"}}.to raise_error(ArgumentError)
      # end

      it "creates valid todolist" do
        expect(List.new(title, [Task.new("a")])).to be_an_instance_of(List)
      end

      # it "raises error when invalid todolist" do
      #   expect {List.new title, [1234]}.to raise_error(ArgumentError)
      #   expect {List.new title, ["a"]}.to raise_error(ArgumentError)
      # end
    end
  end

  describe "#add_task" do
    it "adds a task into array" do
      expect {list1.add_task(Task.new("a"))}.to change{list1.tasks.size}.by(1)
    end

    it "requires one argument" do
      expect {list1.add_task}.to raise_error(ArgumentError)
    end
  end

  describe "#complete_task" do
    it "completes a task successfully" do
      list1.complete_task(0)
      expect(list1.tasks[0].complete?).to eq(true)
    end
    it "requires one argument" do
      expect {list1.complete_task}.to raise_error(ArgumentError)
    end
  end

  describe "#delete_task" do
    it "deletes a task successfully" do
      expect {list1.delete_task(0)}.to change{list1.tasks.size}.by -1
    end
    it "requires one argument" do
      expect {list1.delete_task}.to raise_error(ArgumentError)
    end
  end

  describe "#completed_tasks" do
    it "shows completed tasks" do
      expect {list1.complete_task(0)}.to change {
        list1.completed_tasks.size }.by 1
      task1.complete!
      expect(list1.completed_tasks).to include(task1)
    end
    it "does not show uncompleted tasks" do
      expect {list1.add_task(Task.new("a"))}.not_to change {
        list1.completed_tasks.size
      }
      expect(list1.completed_tasks).not_to include(task2)
    end
  end

end
