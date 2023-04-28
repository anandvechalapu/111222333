using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using 111222333.DTO;
using 111222333.Service;
using Microsoft.AspNetCore.Mvc;

namespace 111222333.API
{
    [Route("api/[controller]")]
    [ApiController]
    public class SharingOfUpsiController : ControllerBase
    {
        private readonly SharingOfUpsiService _sharingOfUpsiService;

        public SharingOfUpsiController(SharingOfUpsiService sharingOfUpsiService)
        {
            _sharingOfUpsiService = sharingOfUpsiService;
        }

        [HttpGet]
        public async Task<ActionResult<ICollection<SharingOfUpsiModel>>> GetAllAsync()
        {
            var result = await _sharingOfUpsiService.GetAllAsync();

            if (result == null || !result.Any())
            {
                return NotFound();
            }

            return Ok(result);
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<SharingOfUpsiModel>> GetByIdAsync(int id)
        {
            var result = await _sharingOfUpsiService.GetByIdAsync(id);

            if (result == null)
            {
                return NotFound();
            }

            return Ok(result);
        }

        [HttpPost]
        public async Task<ActionResult<SharingOfUpsiModel>> CreateAsync(SharingOfUpsiModel model)
        {
            var result = await _sharingOfUpsiService.CreateAsync(model);

            if (result == null)
            {
                return BadRequest();
            }

            return Ok(result);
        }

        [HttpPut]
        public async Task<ActionResult<SharingOfUpsiModel>> UpdateAsync(SharingOfUpsiModel model)
        {
            var result = await _sharingOfUpsiService.UpdateAsync(model);

            if (result == null)
            {
                return BadRequest();
            }

            return Ok(result);
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult> DeleteAsync(int id)
        {
            var isSuccess = await _sharingOfUpsiService.DeleteAsync(id);

            if (!isSuccess)
            {
                return NotFound();
            }

            return Ok();
        }
    }
}