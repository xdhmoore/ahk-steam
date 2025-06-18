class Tab {

   __New(Nav, LeftX, RightX, Y) {
      this.Nav := Nav
      this.LeftX := LeftX
      this.RightX := RightX
      this.Y := Y
   }

   Close() {
      ControlClick("X" . (this.RightX - 13) . " Y53", "ahk_id " . this.Nav.AhkId)
   }

}

class Navigation {

   InActiveTabColor := "0E141B" ; maybe not exact
   ActiveTabColor := "3D4450"

   __New(AhkId) {
      this.AhkId := AhkId
      this.CurrentTab := this.FindCurrentTab()
   }

   FindCurrentTab() {
      WinGetPos(, , &Width, , "ahk_id " . this.AhkId)
      FoundActive := False
      PixelSearch(&LeftX, &Dummy, 5, 36, Width, 36, "0x" . this.ActiveTabColor, 10)
      TabHeight := 67
      ImageSearch(&CloseX, &Dummy, LeftX, 36, Width, TabHeight, "x-cropped.png")
      if (!CloseX) {
         ImageSearch(&CloseX, &Dummy, LeftX, 36, Width, TabHeight, "x-black-cropped.png")
      }
      if (CloseX) {
         ImageXY := 10
         RightX := CloseX + ImageXY
         return Tab(this, LeftX, RightX, 36)
      }
      ; If we didn't find the X, just silently fail
   }

   CloseCurrentTab() {
      this.CurrentTab.Close()
   }

   NextTab() {

   }

}

Main() {
   ; AhkId := WinActive("Steam - Browser")
   AhkId := WinExist("Steam - Browser")
   Navigation(AhkId).CloseCurrentTab()
}

HotIfWinActive("Steam - Browser")
Hotkey("^w", (*) => Main())
