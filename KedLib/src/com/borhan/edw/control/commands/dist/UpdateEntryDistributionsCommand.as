package com.borhan.edw.control.commands.dist
{
	import com.borhan.commands.MultiRequest;
	import com.borhan.commands.entryDistribution.EntryDistributionAdd;
	import com.borhan.commands.entryDistribution.EntryDistributionDelete;
	import com.borhan.commands.entryDistribution.EntryDistributionList;
	import com.borhan.commands.entryDistribution.EntryDistributionSubmitAdd;
	import com.borhan.commands.entryDistribution.EntryDistributionSubmitDelete;
	import com.borhan.edw.control.commands.KedCommand;
	import com.borhan.edw.control.events.EntryDistributionEvent;
	import com.borhan.edw.model.EntryDistributionWithProfile;
	import com.borhan.edw.model.datapacks.EntryDataPack;
	import com.borhan.events.BorhanEvent;
	import com.borhan.bmvc.control.BMvCEvent;
	import com.borhan.types.BorhanEntryDistributionStatus;
	import com.borhan.vo.BorhanEntryDistribution;
	import com.borhan.vo.BorhanEntryDistributionFilter;
	import com.borhan.vo.BorhanEntryDistributionListResponse;

	public class UpdateEntryDistributionsCommand extends KedCommand
	{
		override public function execute(event:BMvCEvent):void 
		{
			var entryDistributionEvent:EntryDistributionEvent = event as EntryDistributionEvent;
			var distributionsToAdd:Array = entryDistributionEvent.distributionsWithProfilesToAddArray;
			var distributionsToRemove:Array = entryDistributionEvent.distributionsToRemoveArray;
			if (distributionsToAdd.length == 0 && distributionsToRemove.length == 0)
				return;
			
			_model.increaseLoadCounter();
			var mr:MultiRequest = new MultiRequest();
			//all entry distributions to add
			var requestsIndex:int = 1;
			for each (var distribution:EntryDistributionWithProfile in distributionsToAdd) {
				//first delete old leftovers, create new entryDistribution if needed
				var addEntryDistribution:EntryDistributionAdd;
				if (distribution.borhanEntryDistribution.status== BorhanEntryDistributionStatus.REMOVED) {
					var deleteEntryDistribution:EntryDistributionDelete = new EntryDistributionDelete(distribution.borhanEntryDistribution.id);
					mr.addAction(deleteEntryDistribution);
					var newEntryDistribution:BorhanEntryDistribution = new BorhanEntryDistribution();
					newEntryDistribution.entryId = distribution.borhanEntryDistribution.entryId;
					newEntryDistribution.distributionProfileId = distribution.borhanEntryDistribution.distributionProfileId;
					addEntryDistribution = new EntryDistributionAdd(newEntryDistribution);
				}
				else {
					addEntryDistribution = new EntryDistributionAdd(distribution.borhanEntryDistribution);
				}
				mr.addAction(addEntryDistribution);
				
				//if submitAdd action is required
				if (!distribution.manualQualityControl) {
					requestsIndex++;
					var submitEntry:EntryDistributionSubmitAdd = new EntryDistributionSubmitAdd(0, true);
					mr.addAction(submitEntry);
//					mr.addRequestParam(requestsIndex + ":id","{" + (requestsIndex-1) + ":result:id}");
					mr.mapMultiRequestParam(requestsIndex-1, "id", requestsIndex, "id");
				}
				requestsIndex++;
			}
			
			//all entry distributions to delete
			for each (var removeDistribution:BorhanEntryDistribution in distributionsToRemove) {
				//remove from destination
				if (removeDistribution.status == BorhanEntryDistributionStatus.READY ||
					removeDistribution.status == BorhanEntryDistributionStatus.ERROR_UPDATING) {
					var removeSubmitEntryDistribution:EntryDistributionSubmitDelete = new EntryDistributionSubmitDelete(removeDistribution.id);
					mr.addAction(removeSubmitEntryDistribution);	
				}
				//if entry wasn't submitted yet, delete it
				else if (removeDistribution.status == BorhanEntryDistributionStatus.QUEUED ||
						 removeDistribution.status == BorhanEntryDistributionStatus.PENDING ||
						 removeDistribution.status == BorhanEntryDistributionStatus.ERROR_SUBMITTING)
				{
					var deleteDistribution:EntryDistributionDelete = new EntryDistributionDelete(removeDistribution.id);
					mr.addAction(deleteDistribution);
				}
			}
			//get the new entry distributions list
			var entryDistributionFilter:BorhanEntryDistributionFilter = new BorhanEntryDistributionFilter();
			var edp:EntryDataPack = _model.getDataPack(EntryDataPack) as EntryDataPack;
			entryDistributionFilter.entryIdEqual = edp.selectedEntry.id;	
			var listDistributions:EntryDistributionList = new EntryDistributionList(entryDistributionFilter);
			mr.addAction(listDistributions);
			
			mr.addEventListener(BorhanEvent.COMPLETE, result);
			mr.addEventListener(BorhanEvent.FAILED, fault);
			_client.post(mr);
		}
		
		override public function result(data:Object):void
		{
			_model.decreaseLoadCounter();
			super.result(data);
			var resultArray:Array = data.data as Array;
			var listDistributionsCommand:ListEntryDistributionCommand = new ListEntryDistributionCommand();
			listDistributionsCommand.handleEntryDistributionResult(resultArray[resultArray.length - 1] as BorhanEntryDistributionListResponse);
		}
	}
}