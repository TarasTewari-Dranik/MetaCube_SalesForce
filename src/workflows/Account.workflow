<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_To_Account_Owner</fullName>
        <description>Email To Account Owner</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Notify_the_account_owner</template>
    </alerts>
    <rules>
        <fullName>NotifyAccountOwnerWhenSomeoneElseUpdates</fullName>
        <actions>
            <name>Email_To_Account_Owner</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notify the account owner when someone else updates the account if the account&apos;s annual revenue is greater than $1,000,000.</description>
        <formula>AND(AnnualRevenue  &gt; 1000000,  LastModifiedById  &lt;&gt;  OwnerId)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
