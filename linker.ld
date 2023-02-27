SECTIONS {
  . = 0x100;

  .text : {
    *(.text)
  }

  .data : {
    *(.data)
  }

  .bss : {
    *(.bss)
  }

  .rodata : {
    *(.rodata)
  }

  .comment : {
    *(.comment)
  }

  .note.gnu.build-id : {
    *(.note.gnu.build-id)
  }

  .shstrtab : {
    *(.shstrtab)
  }

  .symtab : {
    *(.symtab)
  }

  .strtab : {
    *(.strtab)
  }

  .rel.text : {
    *(.rel.text)
  }

  .rela.text : {
    *(.rela.text)
  }

  .rel.data : {
    *(.rel.data)
  }

  .rela.data : {
    *(.rela.data)
  }

  .rel.rodata : {
    *(.rel.rodata)
  }

  .rela.rodata : {
    *(.rela.rodata)
  }

  .rel.bss : {
    *(.rel.bss)
  }

  .rela.bss : {
    *(.rela.bss)
  }

  .rel.common : {
    *(.rel.common)
  }

  .rela.common : {
    *(.rela.common)
  }

  .comment : {
    *(.comment)
  }

  .note.gnu.build-id : {
    *(.note.gnu.build-id)
  }

  .note.ABI-tag : {
    *(.note.ABI-tag)
  }

  /DISCARD/ : {
    *(.eh_frame)
    *(.eh_frame_hdr)
    *(.note.GNU-stack)
  }
}
