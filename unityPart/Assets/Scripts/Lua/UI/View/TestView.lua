--this file is auto created by QuickCode,you can edit it 
--do not need to care initialization of ui widget any more 
--------------------------------------------------------------------------------
--/**
--* @author :
--* date    :
--* purpose :
--*/
--------------------------------------------------------------------------------
require "class"


local TestView = class("TestView");

function TestView:ctor(...)
	--assign transform by your ui framework
	self.transform = nil;
end

--region UI Variable Assignment 
function TestView:InitUI()
	self.canvasscaler_Test = self.transform:GetComponent("CanvasScaler"); 
	self.graphicraycaster_Test = self.transform:GetComponent("GraphicRaycaster"); 
	self.image_Image = self.transform:Find("Image"):GetComponent("Image"); 
	self.inputfield_Image = self.transform:Find("Image"):GetComponent("InputField"); 
	self.image_InputField = self.transform:Find("InputField"):GetComponent("Image"); 
	self.inputfield_InputField = self.transform:Find("InputField"):GetComponent("InputField"); 
	self.text_Placeholder = self.transform:Find("InputField/Placeholder"):GetComponent("Text"); 
	self.text_Text = self.transform:Find("InputField/Text"):GetComponent("Text"); 
	self.text_Text9 = self.transform:Find("Text"):GetComponent("Text"); 

end
--endregion 

--region UI Event Register 
function TestView:AddEvent()

end
--endregion 

return TestView;
