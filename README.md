# Summary

Get pretty text with xccov from made coverage report by Xcode.

# Usage

```
$ xcrun llvm-cov export -instr-profile ~/Library/Developer/Xcode/DerivedData/{YOUR_PROJECT}/Build/Intermediates/CodeCoverage/Coverage.profdata -object ~/Library/Developer/Xcode/DerivedData/{YOUR_PROJECT}/Build/Intermediates/CodeCoverage/Products/Debug-appletvsimulator/{YOUR_APP}/{YOUR_APP_EXE} > export.json
$ xccov -f export.json
```

# License

xccov are published under the Apache 2.0 license.

```
Copyright 2017 Hiroaki ENDOH                                            
                                                                        
Licensed under the Apache License, Version 2.0 (the "License");         
you may not use this file except in compliance with the License.        
You may obtain a copy of the License at                                 
                                                                        
    http://www.apache.org/licenses/LICENSE-2.0                          
                                                                        
Unless required by applicable law or agreed to in writing, software     
distributed under the License is distributed on an "AS IS" BASIS,       
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and     
limitations under the License.                                          
```