defmodule ReactionsService.ReactionsTest do
  use ReactionsService.DataCase

  alias ReactionsService.Reactions

  describe "reactions" do
    alias ReactionsService.Reactions.Reaction

    @valid_attrs %{action: "some action", content_id: "some content_id", reaction_type: "some reaction_type", type: "some type", user_id: "some user_id"}
    @update_attrs %{action: "some updated action", content_id: "some updated content_id", reaction_type: "some updated reaction_type", type: "some updated type", user_id: "some updated user_id"}
    @invalid_attrs %{action: nil, content_id: nil, reaction_type: nil, type: nil, user_id: nil}

    def reaction_fixture(attrs \\ %{}) do
      {:ok, reaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Reactions.create_reaction()

      reaction
    end

    test "list_reactions/0 returns all reactions" do
      reaction = reaction_fixture()
      assert Reactions.list_reactions() == [reaction]
    end

    test "get_reaction!/1 returns the reaction with given id" do
      reaction = reaction_fixture()
      assert Reactions.get_reaction!(reaction.id) == reaction
    end

    test "create_reaction/1 with valid data creates a reaction" do
      assert {:ok, %Reaction{} = reaction} = Reactions.create_reaction(@valid_attrs)
      assert reaction.action == "some action"
      assert reaction.content_id == "some content_id"
      assert reaction.reaction_type == "some reaction_type"
      assert reaction.type == "some type"
      assert reaction.user_id == "some user_id"
    end

    test "create_reaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reactions.create_reaction(@invalid_attrs)
    end

    test "update_reaction/2 with valid data updates the reaction" do
      reaction = reaction_fixture()
      assert {:ok, %Reaction{} = reaction} = Reactions.update_reaction(reaction, @update_attrs)
      assert reaction.action == "some updated action"
      assert reaction.content_id == "some updated content_id"
      assert reaction.reaction_type == "some updated reaction_type"
      assert reaction.type == "some updated type"
      assert reaction.user_id == "some updated user_id"
    end

    test "update_reaction/2 with invalid data returns error changeset" do
      reaction = reaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Reactions.update_reaction(reaction, @invalid_attrs)
      assert reaction == Reactions.get_reaction!(reaction.id)
    end

    test "delete_reaction/1 deletes the reaction" do
      reaction = reaction_fixture()
      assert {:ok, %Reaction{}} = Reactions.delete_reaction(reaction)
      assert_raise Ecto.NoResultsError, fn -> Reactions.get_reaction!(reaction.id) end
    end

    test "change_reaction/1 returns a reaction changeset" do
      reaction = reaction_fixture()
      assert %Ecto.Changeset{} = Reactions.change_reaction(reaction)
    end
  end
end
