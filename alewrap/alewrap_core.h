
// Initializes the ALE.
ALEInterface *ale_new(const char *rom_file);

// Applies the action and returns the obtained reward.
double ale_act(ALEInterface *ale, int action);

// Fills the obs with raw palette values.
// The obs shape should be 210x160.
//
// Currently, the palette values are even numbers from 0 to 255.
// So there are only 128 distinct values.
void ale_fillObs(ALEInterface *ale, uint8_t *obs, int obsSize);

// Fills the given array with the content of the RAM.
// The obsSize should be 128.
void ale_fillRamObs(ALEInterface *ale, uint8_t *obs, int obsSize);

// Converts the palette values to RGB.
// The shape of the rgb array should be 3 x obs.shape.
void ale_fillRgbFromPalette(uint8_t *rgb, uint8_t *obs, int rgbSize, int obsSize);

// Indicates whether the game ended.
// Call resetGame to restart the game.
//
// Returning of bool instead of int is important.
// The bool is converted to lua bool by FFI.
bool ale_isGameOver(ALEInterface *ale);

// Resets the game.
void ale_resetGame(ALEInterface *ale);

// Deletes the ALE pointer.
void ale_gc(ALEInterface *ale);

// ALE save state
void ale_saveState(ALEInterface *ale);

// ALE load state
void ale_loadState(ALEInterface *ale);

// Returns the number of legal actions
int ale_numLegalActions(ALEInterface * ale);

// Returns the valid actions for a game
void ale_legalActions(ALEInterface * ale, int *actions);
