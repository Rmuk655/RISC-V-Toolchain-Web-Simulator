// Smoke test for the WebAssembly build: assemble and run a tiny program through the same
// JavaScript bindings the browser UI uses, and check a register value.
import createModule from "../riscv_node.mjs";

const mod = await createModule();
const sim = new mod.Simulator();

const program = ["addi x1, x0, 5", "addi x2, x0, 7", "add x3, x1, x2"].join("\n");
const rc = sim.load(program);
sim.run();
const regs = sim.getRegisters();
console.log("load() returned", rc);
console.log(regs);

// Registers are printed in hexadecimal, so 5 + 7 = 12 appears as "c".
if (!/\bx3:\s*(0x)?0*c\b/i.test(regs)) {
  console.error("FAIL: expected x3 to hold 12 (0xc) after running the program");
  process.exit(1);
}
console.log("PASS: x3 = 0xc (12)");
