/**
 * @class Memory
 * @brief An abstraction for byte-addressable memory storage.
 *
 * This class simulates a simple memory model using an unordered map to store bytes at specific addresses.
 * It provides methods to write and read values of various sizes (1, 2, or 4 bytes) to and from memory,
 * supporting both signed and unsigned access. The class also allows dumping memory contents for debugging
 * and resetting the memory state.
 *
 * The abstraction hides the underlying storage mechanism, allowing users to interact with memory
 * conceptually (by address and size) without needing to manage the details of byte storage or address mapping.
 *
 */
// E.g : Write 4-byte integer 0x12345678 to address 0x1000
// writeMemory(0x1000, 0x12345678, 4);
//      Internally stores:
//          memory[0x1000] = 0x78;
//          memory[0x1001] = 0x56;
//          memory[0x1002] = 0x34;
//          memory[0x1003] = 0x12;
// Read back:
//      readMemory(0x1000, 4, false) => reconstructs 0x12345678
//      Read val of given size (1, 2, or 4). isUnsigned determines sign-extension

#ifndef MEMORY_H
#define MEMORY_H

#include <unordered_map>
#include <cstdint>
#include <iostream>

enum class MemSize : int
{
    Byte = 1,
    HalfWord = 2,
    Word = 4,
    DoubleWord = 8
};

// Zero- or sign-extends a raw little-endian value of the given size to 64 bits.
// Shared by Memory and CacheBlock so loads give the same result with or without the cache.
inline int64_t extendLoadedValue(uint64_t raw, MemSize size, bool isUnsigned)
{
    if (!isUnsigned)
    {
        switch (size)
        {
        case MemSize::Byte:
            return static_cast<int8_t>(raw);
        case MemSize::HalfWord:
            return static_cast<int16_t>(raw);
        case MemSize::Word:
            return static_cast<int32_t>(raw);
        case MemSize::DoubleWord:
            break;
        }
    }
    return static_cast<int64_t>(raw);
}

class Memory
{
public:
    Memory(std::ostream &out = std::cout) : out(out) {}

    int64_t read(uint32_t address, MemSize size, bool isUnsigned = false) const;
    void write(uint32_t address, MemSize size, uint64_t value);

    void print(uint32_t startAddress, uint32_t count) const;
    void clear();

    // simple byte-addressable memory storage
    std::unordered_map<uint32_t, int8_t> memory;

private:
    std::ostream &out;

    // helper to safely read a byte from memory (returns 0 if not present)
    int8_t getByte(uint32_t address) const
    {
        auto it = memory.find(address);
        if (it != memory.end())
            return it->second;
        return 0;
    }
};

#endif // MEMORY_H
