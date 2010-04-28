
class NullByteInjectionFilter < AttackFilter

  ATTACK_PATTERNS = [
                      "\000", 
                      "\001", 
                      "\027", 
                      "\002", 
                      "\003", 
                      "\004", 
                      "\005", 
                      "\006", 
                      "\007", 
                      "\00",
                      "\a",
                      [0x0000].pack("U*"),
                      [0x0001].pack("U*"),
                      [0x0002].pack("U*"),
                      [0x0003].pack("U*"),
                      [0x0004].pack("U*"),
                      [0x0005].pack("U*"),
                      [0x0006].pack("U*"),
                      [0x0007].pack("U*"),
                      [0x0008].pack("U*"),
                      [0x0009].pack("U*"),
                      [0x000B].pack("U*"),
                      [0x000C].pack("U*") 
                    ]
end
