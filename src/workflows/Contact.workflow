<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>HappyBirthdayEmail</fullName>
        <description>Happy Birthday Email</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/Happy_Birthday</template>
    </alerts>
    <alerts>
        <fullName>Happy_Birthday_Email</fullName>
        <description>Happy Birthday Email</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Happy_Birthday</template>
    </alerts>
    <rules>
        <fullName>SendEmailToContactTwoDaysBeforeDOB</fullName>
        <active>true</active>
        <formula>AND(Email  &lt;&gt; null, NOT(ISNULL( Birthdate )) )</formula>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>HappyBirthdayEmail</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Contact.Birthdate</offsetFromField>
            <timeLength>-2</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
