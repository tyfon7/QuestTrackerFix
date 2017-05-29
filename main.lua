-- This is Blizzard's old implementation, via github.com/tekkub/wow-ui-source
function QUEST_TRACKER_MODULE:OnBlockHeaderClick(block, mouseButton)
    if ( ChatEdit_TryInsertQuestLinkForQuestID(block.id) ) then
        return;
    end

    if ( mouseButton ~= "RightButton" ) then
        CloseDropDownMenus();
        if ( IsModifiedClick("QUESTWATCHTOGGLE") ) then
            QuestObjectiveTracker_UntrackQuest(nil, block.id);
        else
            local questLogIndex = GetQuestLogIndexByID(block.id);
            if ( IsQuestComplete(block.id) and GetQuestLogIsAutoComplete(questLogIndex) ) then
                AutoQuestPopupTracker_RemovePopUp(block.id);
                ShowQuestComplete(questLogIndex);
            else
                QuestLogPopupDetailFrame_Show(questLogIndex);
            end
        end
        return;
    else
        ObjectiveTracker_ToggleDropDown(block, QuestObjectiveTracker_OnOpenDropDown);
    end
end