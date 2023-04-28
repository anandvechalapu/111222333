using 111222333.DTO;
using 111222333.Service;
using Microsoft.AspNetCore.Mvc;

namespace 111222333.API
{
    [Route("api/[controller]")]
    [ApiController]
    public class BatchProcessController : ControllerBase
    {
        private readonly IBatchProcessService _batchProcessService;

        public BatchProcessController(IBatchProcessService batchProcessService)
        {
            _batchProcessService = batchProcessService;
        }

        [HttpPost]
        public async Task<IActionResult> CreateAsync([FromBody] BatchProcessDTO batchProcessDTO)
        {
            var batchProcess = await _batchProcessService.CreateAsync(batchProcessDTO);

            return Ok(batchProcess);
        }
    }
}